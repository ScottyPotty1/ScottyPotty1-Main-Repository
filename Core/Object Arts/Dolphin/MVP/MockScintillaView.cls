"Filed out from Dolphin Smalltalk 7"!

Object subclass: #MockScintillaView
	instanceVariableNames: 'lastStyled tokens text currentTextStyles styleIdMap'
	classVariableNames: ''
	poolDictionaries: 'ScintillaConstants'
	classInstanceVariableNames: ''!
MockScintillaView guid: (GUID fromString: '{50616A84-12E3-4960-B005-82A37278383B}')!
MockScintillaView comment: 'To set up:

	mock := MockScintillaView new.
	mock textStyles: SmalltalkWorkspace defaultTextStyles

Then to style:

	styler := SmalltalkMethodStyler new.
	text := (Object>>#printString) getSource.
	mock text: text.
	styler 
		colorTextFrom: 1
		to: text size
		in: mock.
	"Now can access the ''tokens''"
	mock tokens'!
!MockScintillaView categoriesForClass!Kernel-Objects! !
!MockScintillaView methodsFor!

applyStyle: aSymbol toNext: anInteger 
	self styleNext: anInteger mask: ((self styleNamed: aSymbol) ifNil: [0] ifNotNil: [:style | style id])!

characterAt: anInteger 
	^text at: anInteger!

maxStyle
	^31!

plainTextFrom: startInteger to: stopInteger 
	^text copyFrom: startInteger to: stopInteger!

plainTextRange: anInterval
	^self plainTextFrom: anInterval start to: anInterval stop!

setCurrentTextStyles: aCollection 
	| newStylesByName allocatedStyles newStylesById availableStyles count |
	count := aCollection size.
	allocatedStyles := OrderedCollection new: count.
	aCollection do: [:each | each basicId ifNotNil: [:id | allocatedStyles add: id]].
	availableStyles := ((1 to: STYLE_DEFAULT - 1) , (STYLE_LASTPREDEFINED + 1 to: self maxStyle) 
				difference: allocatedStyles) readStream.
	newStylesByName := IdentityDictionary new: count.
	newStylesById := IdentityDictionary new: count.
	aCollection do: 
			[:each | 
			each basicId isNil ifTrue: [each basicId: availableStyles next].
			newStylesByName at: each name put: each.
			newStylesById at: each basicId put: each].
	newStylesByName at: #normal ifAbsentPut: [ScintillaTextStyle normal].
	currentTextStyles := newStylesByName.
	styleIdMap := newStylesById!

setIndicator: anIntegerOrSymbol from: startInteger length: lengthInteger 
	"Apply the indicator identified by the <integer> id or <symbol> name, anIntegerOrSymbol, to
	the range of text in the receiver starting from the one-base integer character position,
	startInteger, for a run length specified by the <integer>, lengthInteger."

!

startStylingFrom: anInteger 
	lastStyled := anInteger - 1!

styleNamed: aSymbol 
	"Answer a <ScintillaTextStyle> being the named style, or nil if the name is not recognised."

	^currentTextStyles at: aSymbol ifAbsent: []!

styleNext: anInteger mask: anInteger2 
	| range |
	range := lastStyled + 1 to: lastStyled + anInteger.
	range isEmpty ifTrue: [^self].
	range stop > text size ifTrue: [^BoundsError signal: range stop].
	(tokens notEmpty and: [(tokens last at: 2) == anInteger2]) 
		ifTrue: [(tokens last at: 1) stop: range stop]
		ifFalse: [tokens addLast: (Array with: range with: anInteger2)].
	lastStyled := range stop!

styleWithId: anInteger 
	^styleIdMap at: anInteger
		ifAbsent: 
			[(ScintillaTextStyle new)
				name: anInteger;
				yourself]!

stylingPosition
	^lastStyled + 1!

text: aString 
	text := aString.
	lastStyled := 0.
	tokens := OrderedCollection new!

textLength
	^text size!

textStyles: aSet 
	self setCurrentTextStyles: aSet!

tokens
	| answer lastStyle |
	answer := OrderedCollection new.
	lastStyle := nil.
	tokens do: 
			[:each | 
			| id style |
			id := each last bitAnd: self maxStyle.
			style := id == 0 ifTrue: [#whitespace] ifFalse: [(self styleWithId: id) name].
			lastStyle == style 
				ifTrue: 
					[| last |
					last := answer last.
					last at: 1 put: (last first start to: each first stop).
					last at: 3 put: (self plainTextRange: last first)]
				ifFalse: 
					[lastStyle := style.
					answer addLast: (Array 
								with: each first
								with: style
								with: (self plainTextRange: each first))]].
	^answer! !
!MockScintillaView categoriesFor: #applyStyle:toNext:!public!styling! !
!MockScintillaView categoriesFor: #characterAt:!public!unit tests! !
!MockScintillaView categoriesFor: #maxStyle!public!unit tests! !
!MockScintillaView categoriesFor: #plainTextFrom:to:!public!unit tests! !
!MockScintillaView categoriesFor: #plainTextRange:!accessing!public! !
!MockScintillaView categoriesFor: #setCurrentTextStyles:!private!style definition! !
!MockScintillaView categoriesFor: #setIndicator:from:length:!indicators!public! !
!MockScintillaView categoriesFor: #startStylingFrom:!public!unit tests! !
!MockScintillaView categoriesFor: #styleNamed:!accessing!public!styling! !
!MockScintillaView categoriesFor: #styleNext:mask:!public!unit tests! !
!MockScintillaView categoriesFor: #styleWithId:!accessing!public!style definition! !
!MockScintillaView categoriesFor: #stylingPosition!accessing!public! !
!MockScintillaView categoriesFor: #text:!public!unit tests! !
!MockScintillaView categoriesFor: #textLength!public!unit tests! !
!MockScintillaView categoriesFor: #textStyles:!public!unit tests! !
!MockScintillaView categoriesFor: #tokens!public!unit tests! !

