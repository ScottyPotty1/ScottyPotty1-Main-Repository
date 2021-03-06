"Filed out from Dolphin Smalltalk X6"!

GraphicsTool subclass: #Font
	instanceVariableNames: 'logfont resolution'
	classVariableNames: 'System'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
Font guid: (GUID fromString: '{87B4C634-026E-11D3-9FD7-00A0CC3E4A32}')!
Font comment: ''!
!Font categoriesForClass!Graphics-Tools! !
!Font methodsFor!

= aFont
	"Answer true if aFont is equal to (has the same logical font info) as the receiver."

	^self species == aFont species and: [logfont = aFont logFont]!

beBold
	"Set the receiver's bold attribute."

	self isBold: true!

beItalic
	"Set the receiver's italic attribute."

	self isItalic: true!

beUnderlined
	"Set the receiver's underline attribute."

	self isUnderlined: true!

characterSet
	"Answer an <integer> identifying the character set of the receiver."

	^logfont lfCharSet!

characterSet: anInteger 
	"Set the <integer> identifying the character set of the receiver."

	anInteger = self characterSet ifTrue: [^self].
	logfont lfCharSet: anInteger.
	self free!

createHandle
	"Private - Answer an external handle to a new font as described by the logfont structure."

	^GDILibrary default createFontIndirect: logfont!

desktopResolution
	"Private - Answer the resolution of the active desktop."

	^Canvas desktopResolution!

displayOn: aStream
	"Append, to aStream, a String whose characters are a representation of the receiver as a user
	would want to see it."

	self name displayOn: aStream.
	aStream nextPut: $ .
	self pointSize displayOn: aStream.
	aStream nextPutAll: 'pt'.
!

handle: hFont
	"Sets the non-owned handle for the receiver and queries its logical info."

	super handle: hFont.
	self getData: logfont!

hash
	"Answer the SmallInteger hash value for the receiver."

	^logfont hash!

initialize
	"Initialise the receiver."

	super initialize.
	(logfont := LOGFONT new) lfWeight: FW_NORMAL.
	resolution := self desktopResolution.!

isBold
	"Answer whether the receiver is bold."

	^self weight = FW_BOLD!

isBold: aBoolean
	"Set the receiver's bold attribute."

	self weight: (aBoolean ifTrue: [FW_BOLD] ifFalse: [FW_NORMAL])!

isDefault
	"Answer true if the receiver is the default font"

	^self = Font default!

isItalic
	"Answer whether the receiver is itatic."

	^logfont lfItalic ~= 0!

isItalic: aBoolean 
	"Set whether the receiver is an italic typeface."

	self isItalic == aBoolean ifTrue: [^self].
	logfont lfItalic: aBoolean asParameter.
	"Cause the receiver to be re-realized"
	self free!

isStruckThrough
	"Answer whether the strike-out effect is set."

	^logfont lfStrikeOut ~= 0!

isStruckThrough: aBoolean 
	"Set the struck out character effect."

	self isStruckThrough == aBoolean ifTrue: [^self].
	logfont lfStrikeOut: aBoolean asParameter.
	"Cause the receiver to be re-realized"
	self free!

isUnderlined
	"Answer whether the receiver is underlined."

	^logfont lfUnderline ~= 0!

isUnderlined: aBoolean 
	"Reset the receiver's underline attribute."

	self isUnderlined == aBoolean ifTrue: [^self].
	logfont lfUnderline: aBoolean asParameter.
	"Cause the receiver to be re-realized"
	self free!

logFont
	"Answer the receiver's logical attributes."

	^logfont!

logFont: aLOGFONT 
	"Set the receiver's logical attributes."

	logfont := aLOGFONT.
	self free!

name
	"Answer the face name of the font."

	^logfont lfFaceName trimNulls!

name: aString
	"Set the receiver's font name attribute. This has no affect if the receiver is already realized."

	logfont lfFaceName: aString!

pixelFromPoints: size
	"Private - Answers a pixel size from a given point size."

	^(size * resolution y / 72) rounded.
!

pixelSize
	"Answers the receiver's pixel size."

	^self logFont lfHeight abs!

pixelSize: anInteger
	"Set's the receiver's pixel size to anInteger pixels.
	This has no affect if the receiver is already realized."

	self logFont lfHeight: anInteger negated!

pointFromPixels: size
	"Private - Answers a point size from a given pixel size."

	^(size * 72 / resolution y) rounded.
!

pointSize
	"Answers the receiver's point size."

	^self pointFromPixels: self logFont lfHeight abs!

pointSize: anInteger
	"Convert anInteger to pixels and store in the receiver's logfont lfHeight.
	This has no affect if the receiver is already realized."

	self logFont lfHeight: (self pixelFromPoints: anInteger) negated!

postCopy
	"Apply any final flourish to the copy that may be required in order to ensure that the copy
	does not share any state with the original, apart from the elements. Answer the receiver."

	super postCopy.
	logfont := logfont copy.
	^self!

printOn: aStream
	"Append, to aStream, a String whose characters are a description of the receiver as a developer
	would want to see it."

	aStream
		basicPrint: self;
		nextPut: $(; display: self; nextPut: $)!

resolution
	"Answer the logical pixels per inch of the receiver"

	^resolution!

resolution: aPoint 
	"Sets the logical pixels per inch of the receiver"

	"Check the resolution for the receiver to see if it matches
	the supplied resolution in aPoint. If not, then the logical font information
	is rescaled and the receiver's resolution is changed to that in aPoint."

	| oldres |
	resolution = aPoint ifTrue: [^self].
	self free.
	oldres := resolution.
	
	[| ptSize |
	ptSize := self pointSize.
	resolution := aPoint.
	self pointSize: ptSize] 
			ifCurtailed: [resolution := oldres]!

weight
	"Answer the receiver's <integer> 'weight' (thickness)."

	^logfont lfWeight!

weight: anInteger 
	"Set the receiver's 'weight' (thickness)."

	self weight = anInteger ifTrue: [^self].
	logfont lfWeight: anInteger.
	"Cause the receiver to be re-realized"
	self free! !
!Font categoriesFor: #=!comparing!public! !
!Font categoriesFor: #beBold!accessing!public! !
!Font categoriesFor: #beItalic!accessing!public! !
!Font categoriesFor: #beUnderlined!accessing!public! !
!Font categoriesFor: #characterSet!accessing!public! !
!Font categoriesFor: #characterSet:!accessing!public! !
!Font categoriesFor: #createHandle!private!realizing/unrealizing! !
!Font categoriesFor: #desktopResolution!initializing!private! !
!Font categoriesFor: #displayOn:!displaying!public! !
!Font categoriesFor: #handle:!accessing!public! !
!Font categoriesFor: #hash!comparing!public! !
!Font categoriesFor: #initialize!initializing!public! !
!Font categoriesFor: #isBold!public!testing! !
!Font categoriesFor: #isBold:!modes!public! !
!Font categoriesFor: #isDefault!public!testing! !
!Font categoriesFor: #isItalic!public!testing! !
!Font categoriesFor: #isItalic:!modes!public! !
!Font categoriesFor: #isStruckThrough!public!testing! !
!Font categoriesFor: #isStruckThrough:!accessing!public! !
!Font categoriesFor: #isUnderlined!public!testing! !
!Font categoriesFor: #isUnderlined:!modes!public! !
!Font categoriesFor: #logFont!accessing!public! !
!Font categoriesFor: #logFont:!accessing!public! !
!Font categoriesFor: #name!accessing!public! !
!Font categoriesFor: #name:!accessing!public! !
!Font categoriesFor: #pixelFromPoints:!mapping!private! !
!Font categoriesFor: #pixelSize!accessing!public! !
!Font categoriesFor: #pixelSize:!accessing!public! !
!Font categoriesFor: #pointFromPixels:!mapping!private! !
!Font categoriesFor: #pointSize!accessing!public! !
!Font categoriesFor: #pointSize:!accessing!public! !
!Font categoriesFor: #postCopy!copying!public! !
!Font categoriesFor: #printOn:!development!printing!public! !
!Font categoriesFor: #resolution!accessing!public! !
!Font categoriesFor: #resolution:!accessing!public! !
!Font categoriesFor: #weight!accessing!public! !
!Font categoriesFor: #weight:!accessing!public! !

!Font class methodsFor!

default
	"Answers the default font for the system."

	^self system
!

defaultPointSize
	"Private - Answer a default point size to use when it is not explicitly specified"

	^10!

fromLogFont: aLOGFONT
	"Answer a new instance of the receiver with specified logical attributes."

	^self new
		logFont: aLOGFONT;
		yourself!

icon
	"Answers an Icon that can be used to represent this class"

	^##(self) defaultIcon!

name: aString
	"Answer a new instance of the receiver for fontname aString and a default point size"

	^self name: aString pointSize: self defaultPointSize
!

name: aString pixelSize: anInteger
	"Answer a new instance of the receiver for fontname aString, and pixel size anInteger."

	^self new
		name: aString; 
		pixelSize: anInteger;
		yourself!

name: aString pointSize: anInteger
	"Answer a new instance of the receiver for fontname aString, pointsize anInteger."

	^self new
		name: aString; 
		pointSize: anInteger;
		yourself!

onPreStripImage
	"Private - The image is about to be stripped. Nil the lazily initialized cursors to allow
	them to be removed (and also perhaps the ref to the resource library)."

	self uninitialize!

reset
	"Clear down the receiver's lazily initialized class variables."

	System := nil!

system
	"Answer the stock System font."

	System isNil ifTrue: [System := StockFont fromId: SYSTEM_FONT].
	^System!

uninitialize
	"Uninitialize the class variables of the receiver as it is about to be removed from the system."

	System := nil! !
!Font class categoriesFor: #default!instance creation!public! !
!Font class categoriesFor: #defaultPointSize!constants!private! !
!Font class categoriesFor: #fromLogFont:!instance creation!public! !
!Font class categoriesFor: #icon!constants!public! !
!Font class categoriesFor: #name:!instance creation!public! !
!Font class categoriesFor: #name:pixelSize:!instance creation!public! !
!Font class categoriesFor: #name:pointSize:!instance creation!public! !
!Font class categoriesFor: #onPreStripImage!class hierarchy-removing!private! !
!Font class categoriesFor: #reset!instance creation!public! !
!Font class categoriesFor: #system!instance creation!public! !
!Font class categoriesFor: #uninitialize!class hierarchy-removing!private! !

