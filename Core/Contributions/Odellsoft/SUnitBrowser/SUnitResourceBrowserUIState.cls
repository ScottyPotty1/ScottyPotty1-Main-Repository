"Filed out from Dolphin Smalltalk XP 2002 release 6.00"!

SUnitBrowserAbsUIState subclass: #SUnitResourceBrowserUIState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SUnitResourceBrowserUIState guid: (GUID fromString: '{987711FE-782C-4A38-A20F-F1042F01B6D8}')!
SUnitResourceBrowserUIState comment: ''!
!SUnitResourceBrowserUIState categoriesForClass!Unclassified! !
!SUnitResourceBrowserUIState methodsFor!

colorSymbolFor: aResource

	self configuration showBackgroundColors
		ifFalse: [^#white].

	aResource isNil
		ifTrue: [^#white].

	^aResource isAvailable
		ifTrue: [#green]
		ifFalse: [#red]!

detailState

	| aStream |

	aStream := WriteStream on: (String new: 40).

	^aStream
		nextPutAll: self model availableCount printString;
		nextPutAll: ' available, ';
		nextPutAll: self model unavailableCount printString;
		nextPutAll: ' unavailable';
		contents!

iconSymbolFor: aResource

	self configuration showIcons not
		ifTrue: [^nil].

	^aResource isAvailable
		ifTrue: [self greenBallIconSymbol]
		ifFalse: [self redBallIconSymbol]!

resultStateColorSymbol

	^self model unavailableResources isEmpty
		ifTrue: [#green]
		ifFalse: [#red]! !
!SUnitResourceBrowserUIState categoriesFor: #colorSymbolFor:!color!public! !
!SUnitResourceBrowserUIState categoriesFor: #detailState!public!strings! !
!SUnitResourceBrowserUIState categoriesFor: #iconSymbolFor:!icons!public! !
!SUnitResourceBrowserUIState categoriesFor: #resultStateColorSymbol!color!public! !

