"Filed out from Dolphin Smalltalk 7"!

SelectableItemsTest subclass: #SelectableListItemsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SelectableListItemsTest guid: (GUID fromString: '{48F12746-E517-4013-8077-973B1D783F60}')!
SelectableListItemsTest comment: ''!
!SelectableListItemsTest categoriesForClass!Unclassified! !
!SelectableListItemsTest methodsFor!

autoSelectsFirst
	^false!

objectsToTest
	^(OrderedCollection new)
		add: 5;
		add: 0;
		add: 'Hello';
		add: #(1 2 3);
		add: 0 @ 0;
		yourself!

removingResetsSelection
	^true!

testAddDoesNotChangeSelection
	"add should not upset selection"

	| objects |
	objects := self objectsToTest.
	presenter model removeAll.
	self assert: presenter hasSelection not.
	"Add first object - some presenters auto-select first, e.g. TabView"
	self autoSelectsFirst 
		ifFalse: 
			[self 
				shouldnt: [presenter model add: objects first]
				triggerAnyOf: #(#selectionChanged #selectionChanging:)
				against: presenter.
			self assert: presenter hasSelection not]
		ifTrue: 
			[self 
				should: [presenter model add: objects first]
				trigger: #selectionChanged
				against: presenter.
			self assert: presenter selection == objects first].
	"Now add a second object, usually no selection unless auto selects first"
	self 
		shouldnt: [presenter model add: objects last]
		triggerAnyOf: #(#selectionChanged #selectionChanging:)
		against: presenter.
	self assert: presenter hasSelection == self autoSelectsFirst.
	"With first object selected, insert an object in the middle"
	presenter selection: objects first.
	self 
		shouldnt: [presenter model add: objects second afterIndex: 1]
		triggerAnyOf: #(#selectionChanged #selectionChanging:)
		against: presenter.
	self assert: presenter selectionByIndex = 1.
	self assert: presenter selection == objects first.
	"Test that caching of last selection (if any) remains up to date"
	self 
		shouldnt: [presenter selectionByIndex: 1]
		triggerAnyOf: #(#selectionChanged #selectionChanging:)
		against: presenter.
	"Now insert an item at the front, the selection index moves down"
	self 
		shouldnt: [presenter model addFirst: (objects at: 3)]
		triggerAnyOf: #(#selectionChanged #selectionChanging:)
		against: presenter.
	"Test that caching of last selection (if any) remains up to date (should move down 1)"
	self 
		shouldnt: [presenter selectionByIndex: 2]
		triggerAnyOf: #(#selectionChanged #selectionChanging:)
		against: presenter.
	self assert: presenter selection == objects first.
	"Add another object at the front, selection moves down again"
	self 
		shouldnt: [presenter model addFirst: (objects at: 4)]
		triggerAnyOf: #(#selectionChanged #selectionChanging:)
		against: presenter.
	"Test that caching of last selection (if any) remains up to date"
	self 
		shouldnt: [presenter selectionByIndex: 3]
		triggerAnyOf: #(#selectionChanged #selectionChanging:)
		against: presenter.
	self assert: presenter selection == objects first!

testAddRemove
	"Test adding and removing to the model"

	| objects |
	objects := self objectsToTest.
	1 to: objects size
		do: 
			[:n | 
			1 to: n do: [:i | presenter model add: (objects at: i)].
			1 to: n do: [:i | self assertContains: (objects at: i)].
			1 to: n do: [:i | presenter model remove: (objects at: i)].
			1 to: n do: [:i | self denyContains: (objects at: i)]].
	presenter model addAll: objects.
	objects do: [:each | self assertContains: each].
	presenter model removeAll.
	objects do: [:each | self denyContains: each].
	self assert: presenter view size = 0!

testRemoveAllSelection
	| objects |
	objects := self objectsToTest.
	(presenter model)
		removeAll;
		addAll: objects.
	1 to: objects size
		do: 
			[:each | 
			presenter selectionByIndex: each.
			self 
				should: [presenter model removeAll]
				trigger: #selectionChanged
				against: presenter.
			self assert: presenter hasSelection not.
			presenter model addAll: objects].
	1 to: objects size
		do: 
			[:each | 
			presenter selectionByIndex: each.
			self 
				shouldnt: [presenter model removeAll]
				trigger: #selectionChanging:
				against: presenter.
			self assert: presenter hasSelection not.
			presenter model addAll: objects].
	"Note subtle difference - this time we remove all the objects by passing them as a collection,
	rather than telling the model to empty itself which is handled differently"
	1 to: objects size
		do: 
			[:each | 
			presenter selectionByIndex: each.
			self 
				should: [presenter model removeAll: objects]
				trigger: #selectionChanged
				against: presenter.
			self assert: presenter hasSelection not.
			presenter model addAll: objects].
	1 to: objects size
		do: 
			[:each | 
			presenter selectionByIndex: each.
			self 
				shouldnt: [presenter model removeAll: objects]
				trigger: #selectionChanging:
				against: presenter.
			self assert: presenter hasSelection not.
			presenter model addAll: objects]!

testRemoveDoesNotAffectSelection
	| objects |
	objects := self objectsToTest.
	(presenter model)
		removeAll;
		addAll: objects.
	presenter selectionByIndex: 2.
	self 
		shouldnt: 
			["Remove an object after the selection"

			presenter model removeAtIndex: 3]
		trigger: #selectionChanged
		against: presenter.
	self assert: presenter selectionByIndex == 2.
	self 
		shouldnt: [presenter selectionByIndex: 2]
		trigger: #selectionChanging:
		against: presenter.
	"Remove an object before the selection"
	self 
		shouldnt: [presenter model removeAtIndex: 1]
		trigger: #selectionChanged
		against: presenter.
	self assert: presenter selectionByIndex == 1.
	self 
		shouldnt: [presenter selectionByIndex: 1]
		trigger: #selectionChanging:
		against: presenter.
	"Finally remove the selection"
	self 
		should: [presenter model removeAtIndex: 1]
		trigger: #selectionChanged
		against: presenter.
	self removingResetsSelection ifTrue: [self assert: presenter hasSelection not] ifFalse: []!

testRemoveSelection
	"remove of selected object should trigger #selectionChanged and leave no selection"

	| objects |
	objects := self objectsToTest.
	presenter model addAll: objects.
	objects asSet do: 
			[:each | 
			presenter selection: each.
			self 
				should: [presenter model remove: each]
				trigger: #selectionChanged
				against: presenter.
			(self removingResetsSelection or: [presenter model isEmpty]) 
				ifTrue: 
					[self assert: presenter selectionOrNil isNil.
					self assert: presenter selectionByIndex = 0]
				ifFalse: 
					[| sel |
					sel := presenter selectionOrNil.
					self assert: sel notNil.
					self assert: sel ~~ each]].
	^objects!

testResetSelection
	| objects |
	objects := self objectsToTest.
	(presenter model)
		removeAll;
		addAll: objects.
	1 to: objects size
		do: 
			[:n | 
			presenter selectionByIndex: n.
			self 
				should: [presenter resetSelection]
				trigger: #selectionChanged
				against: presenter.
			self assert: presenter selectionOrNil isNil.
			self assert: presenter selectionByIndex = 0.
			self should: [presenter selection] raise: Error].
	^objects!

testSelection
	"Test selection - in particular that programmatic changes trigger a #selectionChanged, but not
	#selectionChanging:"

	| objects |
	objects := self objectsToTest.
	(presenter model)
		removeAll;
		addAll: objects.
	presenter resetSelection.
	objects do: 
			[:each | 
			self 
				should: [presenter selection: each]
				trigger: #selectionChanged
				against: presenter.
			self assert: presenter selection == each].
	presenter resetSelection.
	objects do: 
			[:each | 
			self 
				shouldnt: [presenter selection: each]
				trigger: #selectionChanging:
				against: presenter.
			self assert: presenter selection == each].
!

testSelectionByIndex
	"selectionByIndex should trigger #selectionChanged"

	| objects start |
	objects := self objectsToTest.
	presenter model addAll: objects.
	start := self autoSelectsFirst 
				ifTrue: 
					[self assert: presenter selection == objects first.
					2]
				ifFalse: 
					[self assert: presenter hasSelection not.
					1].
	start to: objects size
		do: 
			[:n | 
			self 
				should: [presenter selectionByIndex: n]
				trigger: #selectionChanged
				against: presenter.
			self assert: presenter selectionByIndex = n.
			self assert: presenter selection = (objects at: n)].
	^objects!

testSetTextBlockDoesNotAffectSelection
	| objects |
	objects := self objectsToTest.
	(presenter model)
		removeAll;
		addAll: objects.
	presenter selectionByIndex: 2.
	self 
		shouldnt: 
			["Remove an object after the selection"
			presenter view getTextBlock: [:each | each printString , ' &c']]
		trigger: #selectionChanged
		against: presenter.
	self assert: presenter selectionByIndex == 2.
	self 
		shouldnt: [presenter selectionByIndex: 2]
		trigger: #selectionChanging:
		against: presenter!

testUpdateSelectedObject
	"Updating objects should not affect the selection"

	(presenter model)
		removeAll;
		addAll: self objectsToTest.
	presenter selectionByIndex: 2.
	self 
		shouldnt: [presenter model refreshAtIndex: 1]
		trigger: #selectionChanged
		against: presenter.
	self assert: presenter selectionByIndex = 2.
	"Test internal cache of last selection is maintained correctly (if any)"
	self 
		shouldnt: [presenter selectionByIndex: 2]
		trigger: #selectionChanging:
		against: presenter.
	self 
		shouldnt: [presenter model refreshAtIndex: 2]
		trigger: #selectionChanged
		against: presenter.
	self assert: presenter selectionByIndex = 2.
	"Test internal cache of last selection is maintained correctly (if any)"
	self 
		shouldnt: [presenter selectionByIndex: 2]
		trigger: #selectionChanging:
		against: presenter! !
!SelectableListItemsTest categoriesFor: #autoSelectsFirst!private!testing! !
!SelectableListItemsTest categoriesFor: #objectsToTest!helpers!private! !
!SelectableListItemsTest categoriesFor: #removingResetsSelection!private!testing! !
!SelectableListItemsTest categoriesFor: #testAddDoesNotChangeSelection!public!unit tests! !
!SelectableListItemsTest categoriesFor: #testAddRemove!public!unit tests! !
!SelectableListItemsTest categoriesFor: #testRemoveAllSelection!public!unit tests! !
!SelectableListItemsTest categoriesFor: #testRemoveDoesNotAffectSelection!public!unit tests! !
!SelectableListItemsTest categoriesFor: #testRemoveSelection!public!unit tests! !
!SelectableListItemsTest categoriesFor: #testResetSelection!public!unit tests! !
!SelectableListItemsTest categoriesFor: #testSelection!public!unit tests! !
!SelectableListItemsTest categoriesFor: #testSelectionByIndex!public!unit tests! !
!SelectableListItemsTest categoriesFor: #testSetTextBlockDoesNotAffectSelection!public!unit tests! !
!SelectableListItemsTest categoriesFor: #testUpdateSelectedObject!public!unit tests! !

!SelectableListItemsTest class methodsFor!

isAbstract
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^self == ##(self)! !
!SelectableListItemsTest class categoriesFor: #isAbstract!public!Testing! !

