"Filed out from Dolphin Smalltalk X6.1"!

Win32Structure subclass: #BITMAP
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BITMAP guid: (GUID fromString: '{F44C9143-2B3F-11D3-8368-7A8B5A000000}')!
BITMAP comment: 'BITMAP is an <ExternalStructure> class to represent the Win32 structure of the same name.

The BITMAP structure is used to describe bitmaps, containing attributes such as the width, height, and color format, and a pointer to the bitmap''s bits.'!
!BITMAP categoriesForClass!External-Data-Structured-Win32! !
!BITMAP methodsFor!

bmBits
	"Answer the receiver's bmBits field as a Smalltalk object."

	^(bytes uintPtrAtOffset: ##(self offsetOf: #bmBits)) asExternalAddress!

bmBitsPixel
	"Answer the receiver's bmBitsPixel field as a Smalltalk object."

	^bytes wordAtOffset: ##(self offsetOf: #bmBitsPixel)!

bmHeight
	"Answer the receiver's bmHeight field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #bmHeight)!

bmPlanes
	"Answer the receiver's bmPlanes field as a Smalltalk object."

	^bytes wordAtOffset: ##(self offsetOf: #bmPlanes)!

bmType
	"Answer the receiver's bmType field as a Smalltalk object."

	^bytes sdwordAtOffset: 0!

bmWidth
	"Answer the receiver's bmWidth field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #bmWidth)!

bmWidthBytes
	"Answer the receiver's bmWidthBytes field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #bmWidthBytes)!

depth
	"Answer the colour depth of the bitmap described by the receiver."

	^self bmBitsPixel!

extent
	"Answer the width and height (in pels) of the the bitmap described by the receiver."

	^self bmWidth @ self bmHeight! !
!BITMAP categoriesFor: #bmBits!**compiled accessors**!public! !
!BITMAP categoriesFor: #bmBitsPixel!**compiled accessors**!public! !
!BITMAP categoriesFor: #bmHeight!**compiled accessors**!public! !
!BITMAP categoriesFor: #bmPlanes!**compiled accessors**!public! !
!BITMAP categoriesFor: #bmType!**compiled accessors**!public! !
!BITMAP categoriesFor: #bmWidth!**compiled accessors**!public! !
!BITMAP categoriesFor: #bmWidthBytes!**compiled accessors**!public! !
!BITMAP categoriesFor: #depth!accessing!public! !
!BITMAP categoriesFor: #extent!accessing!public! !

!BITMAP class methodsFor!

defineFields
	"Define the Win32 BITMAP structure
		BITMAP compileDefinition

		typedef struct tagBITMAP {  // bm 
			   LONG   bmType; 
			   LONG   bmWidth; 
			   LONG   bmHeight; 
			   LONG   bmWidthBytes; 
			   WORD   bmPlanes; 
			   WORD   bmBitsPixel; 
			   LPVOID bmBits; 
		} BITMAP;"

	self
	     defineField: #bmType type: SDWORDField readOnly;
	     defineField: #bmWidth type: SDWORDField readOnly;
	     defineField: #bmHeight type: SDWORDField readOnly;
	     defineField: #bmWidthBytes type: SDWORDField readOnly;
	     defineField: #bmPlanes type: WORDField readOnly;
	     defineField: #bmBitsPixel type:WORDField readOnly;
	     defineField: #bmBits type: LPVOIDField readOnly!

fileOutStem
	"Private - Answer standard file name stem for the class to file out on."

	^'BITMAP_Struct'! !
!BITMAP class categoriesFor: #defineFields!initializing!public! !
!BITMAP class categoriesFor: #fileOutStem!private!source filing! !

