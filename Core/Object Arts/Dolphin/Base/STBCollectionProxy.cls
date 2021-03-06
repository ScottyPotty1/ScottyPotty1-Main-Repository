"Filed out from Dolphin Smalltalk X6"!

STBProxy subclass: #STBCollectionProxy
	instanceVariableNames: 'class array'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
STBCollectionProxy guid: (GUID fromString: '{87B4C6EB-026E-11D3-9FD7-00A0CC3E4A32}')!
STBCollectionProxy comment: ''!
!STBCollectionProxy categoriesForClass!System-Binary storage! !
!STBCollectionProxy methodsFor!

array: anArray
	"Private - Set the array inst var to anArray, the elements of the collection represented by the receiver.
	The use of the empty array literal enables the STBOutFiler to issue a shorter object reference for
	any subsequent empty instances of the receiver."

	array := anArray isEmpty
		ifTrue: [#()]
		ifFalse: [anArray]
!

class: aClass
	"Private - Set the class of the object represented by the receiver."

	class := aClass
!

value
	"Answer a new collection of class class and elements array."

	^class withAll: array! !
!STBCollectionProxy categoriesFor: #array:!accessing!private! !
!STBCollectionProxy categoriesFor: #class:!accessing!private! !
!STBCollectionProxy categoriesFor: #value!converting!public! !

!STBCollectionProxy class methodsFor!

class: aClass array: anArray
	"Answer a new instance containing the class and elements of
	the collection that it represents."

	^self basicNew
		class: aClass;
		array: anArray;
		yourself
	!

for: aCollection 
	#deprecated.
	^self forCollection: aCollection!

forCollection: aCollection 
	"Answer a new instance representing aCollection."

	^self class: aCollection class array: aCollection asArray! !
!STBCollectionProxy class categoriesFor: #class:array:!instance creation!public! !
!STBCollectionProxy class categoriesFor: #for:!instance creation!public! !
!STBCollectionProxy class categoriesFor: #forCollection:!instance creation!public! !

