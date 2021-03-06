"Filed out from Dolphin Smalltalk X6"!

WeakLookupTable variableSubclass: #WeakIdentityDictionary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
WeakIdentityDictionary guid: (GUID fromString: '{87B4C534-026E-11D3-9FD7-00A0CC3E4A32}')!
WeakIdentityDictionary comment: ''!
!WeakIdentityDictionary categoriesForClass!Collections-Unordered!Collections-Weak! !
!WeakIdentityDictionary methodsFor!

findKeyOrNil: anObject 
	"Private - This method is a copy of IdentityDictionary>>findKeyOrNil:"

	| capacity index |
	capacity := self basicSize.
	index := self hash: anObject max: capacity.
	
	[| key |
	(key := self basicAt: index) isNil or: [key == anObject]] 
			whileFalse: [index := index \\ capacity + 1].
	^index!

hash: anObject max: anInteger
	^anInteger < 8192 
		ifTrue: [anObject identityHash \\ anInteger + 1]
		ifFalse: [anObject identityHash * (anInteger bitShift: -12) \\ anInteger + 1]!

keysClass
	"Answer the class of Collection to be used for collecting the keys of the receiver"
	
	^IdentitySet!

searchPolicy
	"Answer the receiver's <searchPolicy>."

	^SearchPolicy identity!

species
	"Answer the class of object to be used when copying the receiver. There isn't much
	point answering a weak collection, as elements may expire after selection/collection, etc, 
	which is less than useful."

	^IdentityDictionary! !
!WeakIdentityDictionary categoriesFor: #findKeyOrNil:!private!searching! !
!WeakIdentityDictionary categoriesFor: #hash:max:!private!searching! !
!WeakIdentityDictionary categoriesFor: #keysClass!constants!public! !
!WeakIdentityDictionary categoriesFor: #searchPolicy!constants!public! !
!WeakIdentityDictionary categoriesFor: #species!accessing!public! !

!WeakIdentityDictionary class methodsFor!

initialize
	"Initialize the receiver.
	Class initialize methods are ignored by the SourceManager unless directly implemented
	so we must implement to get the bereavement notifications."

	super initialize!

new: anInteger
	"Answer a new instance of the receiver sufficient capacity for anInteger elements. Both keys and values
	are weakly referenced. By default WeakIdentityDictionaries have both weak key and weak value references."

	^(super new: anInteger)
		haveWeakKeys;
		yourself! !
!WeakIdentityDictionary class categoriesFor: #initialize!development!initializing!public! !
!WeakIdentityDictionary class categoriesFor: #new:!instance creation!public! !

WeakIdentityDictionary class methodProtocol: #'IdentityDictionary factory' attributes: #(#ansi #readOnly) selectors: #(#new #new: #withAll:)!

