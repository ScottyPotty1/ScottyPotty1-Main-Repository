"Filed out from Dolphin Smalltalk 7"!

CommonDialog subclass: #ColorDialog
	instanceVariableNames: 'validationBlock'
	classVariableNames: 'CustomColors WM_COLOROK'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ColorDialog guid: (GUID fromString: '{87B4C6B0-026E-11D3-9FD7-00A0CC3E4A32}')!
ColorDialog comment: 'ColorDialog is a <valueDialogPresenter> implementing the Windows ChooseColor common dialog. The associated <valueModel> contains the <color> chosen.

Instance Variables:
	hook			<BlockCallback>
	validationBlock	<monadicValuable> discriminator used to validate current colour choice and permit/deny use of the OK button.

Class Variables:
	CustomColors	<DWORDArray> of <COLORREFS> holding the current custom colours.
	WM_COLOROK	<integer>. Windows message registered for ''commdlg_ColorOK''


'!
!ColorDialog categoriesForClass!MVP-Presenters! !
!ColorDialog methodsFor!

basicShowModal
	"Private - Create and show a new Colour dialog. Hang it off the receiver's parentView.
	Answer a <Color> based on the dialog selection, or nil if no selection was made. "

	^ComDlgLibrary default chooseColor: self winStruct asParameter!

defaultColor
	^ColorRef defaultColorRepresentation!

extractResult: aBoolean 
	"Private - Extract and apply the result from the parameter structure passed to the Win32 API
	associated with this common dialog, immediately after the call to that API."

	| color |
	aBoolean ifFalse: [^self checkError].
	color := self winStruct color.
	color = self defaultColor 
		ifTrue: [self value: Color default]
		ifFalse: 
			[color isNone 
				ifFalse: 
					[| std |
					std := color asIndexedColor.
					std asRGB = color ifTrue: [color := std] ifFalse: [color]].
			self value: color].
	self apply!

initialize
	validationBlock := [:color | true].
	super initialize!

prepareStruct
	"Private - Initialize the parameter structure to be passed to the Win32 API associated with
	this common dialog, immediately prior to the call to that API."

	"Install the default color as the last custom value"

	| customColors color |
	customColors := self class customColors.
	customColors at: customColors size put: self defaultColor asParameter.
	color := self value isNil ifTrue: [self defaultColor] ifFalse: [self value].
	(self winStruct)
		hInstance: VMLibrary default applicationHandle;
		rgbResult: color asColorRef asParameter;
		maskIn: CC_RGBINIT;
		lpCustColors: customColors!

validationBlock
	^validationBlock!

validationBlock: aMonadicValuable 
	"Set the <monadicValuable> used to validate the user's reply. The valuable is passed the
	current <Color> choice as its argument, and is expected to answer whether it is valid. The
	dialog cannot be Ok'd until the validationBlock answers true."

	"N.B. If validation fails it is adisable to inform the user in some way as otherwise they
	won't understand why the OK button is not working. One way to do this is to show a message
	box from the validation block."

	validationBlock := aMonadicValuable!

winStructClass
	"Private - Answer the class to use for the receiver's associated windows parameter structure."

	^CHOOSECOLOR!

wmColorOk: msgInteger wParam: wParamInteger lParam: lParamInteger 
	"Private - The user has pressed the OK button."

	^(self validationBlock value: winStruct color) ifTrue: [0] ifFalse: [1]! !
!ColorDialog categoriesFor: #basicShowModal!private!realizing/unrealizing! !
!ColorDialog categoriesFor: #defaultColor!helpers!private! !
!ColorDialog categoriesFor: #extractResult:!helpers!private! !
!ColorDialog categoriesFor: #initialize!accessing!initializing!private! !
!ColorDialog categoriesFor: #prepareStruct!helpers!private! !
!ColorDialog categoriesFor: #validationBlock!accessing!public! !
!ColorDialog categoriesFor: #validationBlock:!accessing!public! !
!ColorDialog categoriesFor: #winStructClass!constants!private! !
!ColorDialog categoriesFor: #wmColorOk:wParam:lParam:!event handling-win32!private! !

!ColorDialog class methodsFor!

customColors
	"Answer sufficient static object to hold the 16 COLORREFS to store the custom
	colours across uses of the color dialog. Note that the 16th custom colour is 
	used to hold the default colour and will be installed on each invocation."

	CustomColors isNil 
		ifTrue: 
			[| white |
			CustomColors := DWORDArray new: 16.
			white := Color white asParameter.
			1 to: 15 do: [:index | CustomColors at: index put: white]].
	^CustomColors!

defaultModel
	"Answer a default model to be assigned to the receiver when it
	is initialized."

	^Color black asValue
!

icon
	^##(self) defaultIcon!

initialize
	"Private - Initialize the receiver's class variables.
		self initialize
	"

	self initializeDefaultHooks.
	self registerColorOkMessage.
	SessionManager current 
		when: #sessionStarted
		send: #onStartup
		to: self!

onStartup
	"Perform initialisation at system startup."

	self registerColorOkMessage!

registerColorOkMessage
	WM_COLOROK notNil ifTrue: [hookHandlers removeKey: WM_COLOROK ifAbsent: []].
	WM_COLOROK := UserLibrary default registerWindowMessage: 'commdlg_ColorOK'.
	hookHandlers at: WM_COLOROK put: #wmColorOk:wParam:lParam:!

resetCustomColors
	"Reset the stored custom colors."

	CustomColors := nil!

uninitialize
	"Private - Uninitialize the receiver as it is about to be removed from the system.
		self uninitialize
	"

	SessionManager current removeEventsTriggeredFor: self! !
!ColorDialog class categoriesFor: #customColors!accessing!public! !
!ColorDialog class categoriesFor: #defaultModel!models!public! !
!ColorDialog class categoriesFor: #icon!constants!public! !
!ColorDialog class categoriesFor: #initialize!initializing!private! !
!ColorDialog class categoriesFor: #onStartup!events-session!public! !
!ColorDialog class categoriesFor: #registerColorOkMessage!events-session!public! !
!ColorDialog class categoriesFor: #resetCustomColors!accessing!public! !
!ColorDialog class categoriesFor: #uninitialize!development!initializing!private! !

