"Filed out from Dolphin Smalltalk X6.1"!

Dialog subclass: #MenuItemDialog
	instanceVariableNames: 'titlePresenter commandPresenter iconPresenter imageModel iconIdPresenter inspector cardsPresenter'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
MenuItemDialog guid: (GUID fromString: '{EC0E406D-75F7-437D-8D69-34CFD92846B7}')!
MenuItemDialog comment: 'MenuItemDialog is the abstract class of <dialogPresenter>s used to edit menu entries.

Instance Variables:
	titlePresenter		<TextPresenter> for the #title aspect.
	commandPresenter	<TextPresenter> for the #commandString aspect.
	iconPresenter		<ImagePresenter>
	imageModel			<ValueAspectAdaptor>
	iconIdPresenter		<TextPresenter>
'!
!MenuItemDialog categoriesForClass!Unclassified! !
!MenuItemDialog methodsFor!

chooseIcon
	Icon choose ifNotNil: [:icon | imageModel value: icon]!

clearIcon
	imageModel value: nil!

createComponents
	"Create the presenters contained by the receiver"

	super createComponents.
	titlePresenter := self add: TextPresenter new name: 'title'.
	commandPresenter := self add: TextPresenter new name: 'command'.
	iconPresenter := self add: ImagePresenter new name: 'icon'.
	iconIdPresenter := self add: TextPresenter new name: 'iconId'.
	inspector := self add: PublishedAspectInspector new name: 'inspector'
!

createSchematicWiring
	super createSchematicWiring.
	inspector 
		when: #inspecteeChanged
		send: #onInspecteeChanged
		to: self!

menuBitmapFromIcon: icon 
	^icon asMenuBitmap!

model: aCommandMenuItem 
	"Set the model associated with the receiver."

	| aspectBuffer |
	super model: aCommandMenuItem.
	aspectBuffer := self model.
	titlePresenter model: (aspectBuffer aspectValue: #description).
	commandPresenter model: (aspectBuffer aspectValue: #commandString).
	imageModel := aspectBuffer aspectValue: #image.
	iconPresenter model: (ValueConverter subject: imageModel
				typeConverter: (PluggableTypeConverter leftToRight: [:icon | self menuBitmapFromIcon: icon]
						rightToLeft: [:icon | icon])).
	iconIdPresenter model: (ValueConverter subject: imageModel
				typeConverter: (PluggableTypeConverter leftToRight: [:icon | icon printString]
						rightToLeft: [:id | Icon fromId: id])).
	inspector model: aspectBuffer value!

onCardChanged
	cardsPresenter currentCard = inspector view parentView ifTrue: [inspector refresh]!

onInspecteeChanged
	self model notifyChanged!

onViewOpened
	super onViewOpened.
	cardsPresenter := self view viewNamed: 'cards'.
	cardsPresenter 
		when: #currentCardChanged
		send: #onCardChanged
		to: self!

queryCommand: aCommandQuery 
	"Enters details about a potential command for the receiver into the <CommandQuery>
	arugment."

	| cmd |
	cmd := aCommandQuery commandSymbol.
	#clearIcon == cmd 
		ifTrue: 
			[aCommandQuery isEnabled: imageModel value notNil.
			^true].
	^super queryCommand: aCommandQuery ! !
!MenuItemDialog categoriesFor: #chooseIcon!commands!private! !
!MenuItemDialog categoriesFor: #clearIcon!commands!private! !
!MenuItemDialog categoriesFor: #createComponents!public! !
!MenuItemDialog categoriesFor: #createSchematicWiring!initializing!public! !
!MenuItemDialog categoriesFor: #menuBitmapFromIcon:!private! !
!MenuItemDialog categoriesFor: #model:!public! !
!MenuItemDialog categoriesFor: #onCardChanged!event handling!private! !
!MenuItemDialog categoriesFor: #onInspecteeChanged!event handling!private! !
!MenuItemDialog categoriesFor: #onViewOpened!event handling!public! !
!MenuItemDialog categoriesFor: #queryCommand:!public! !

!MenuItemDialog class methodsFor!

icon
	"Answers an Icon that can be used to represent this class."

	^Menu icon
! !
!MenuItemDialog class categoriesFor: #icon!constants!public! !

