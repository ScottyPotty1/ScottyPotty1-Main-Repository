"Filed out from Dolphin Smalltalk 7"!

STBFiler subclass: #STBOutFiler
	instanceVariableNames: 'writeMap globals globalNils proxyOverrides refOffset'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
STBOutFiler guid: (GUID fromString: '{87B4C6E8-026E-11D3-9FD7-00A0CC3E4A32}')!
STBOutFiler comment: '<STBOutFiler> is the basic binary filer for serializing a tree of <Object>s to a byte stream.

Instance Variables:
	writeMap		<IdentityDictionary>. Map of <Object>s to their <SmallInteger> id in the binary output stream.
	globals		<IdentityDictionary>. Map of global <Object>s to their associated global name <Symbol>s.
	globalNils		<OrderedCollection> of <Symbol>s being the names of nil value global variables written to the stream.
	proxyOverrides	<IdentityDictionary>. Map of <Object>s to the <STBProxy>s (or special values) output in their place.

'!
!STBOutFiler categoriesForClass!System-Binary storage! !
!STBOutFiler methodsFor!

basicNextPut: anObject 
	"Private - Write anObject to the stream in STB format."

	anObject isNil ifTrue: [^self writeInteger: 0].
	"If anObject has been registered as a global then we wrap it up as an STBGlobalObjectProxy
	and output that instead."
	(self objectIsGlobal: anObject) ifTrue: [^self putGlobal: anObject].

	"SmallIntegers can be encoded entirely within the prefix."
	anObject isImmediate 
		ifTrue: 
			[anObject class == SmallInteger 
				ifTrue: [^self writeInteger: (STBPrefix forSmallInteger: anObject) dword].

			"Characters can be encoded entirely within the prefix."
			anObject class == Character ifTrue: [^self writeInteger: (STBPrefix forCharacter: anObject) dword].
			self error: 'unrecognised immediate object type'].

	"References to objects already output can also be encoded entirely within the prefix."
	(self refForObject: anObject) 
		ifNotNil: [:refIndex | ^self writeInteger: (STBPrefix forObjectRef: refIndex) dword].

	"If anObject is the subject of an override:with: message then we output the 'with' proxy object instead."
	proxyOverrides at: anObject
		ifPresent: 
			[:objectToSave | 
			objectToSave notNil ifTrue: [proxyOverrides removeKey: anObject].
			^self saveObject: anObject as: objectToSave].
	(self objectIsLiteral: anObject) ifTrue: [^self putLiteral: anObject].

	"Let anObject output itself."
	anObject stbSaveOn: self!

nextPut: anObject
	"Write anObject to the stream in STB format."

	self basicNextPut: anObject.
	^anObject!

objectIsGlobal: anObject 
	"Private - Answer true if anObject has been registered as global."

	anObject isNil ifTrue: [^globalNils notEmpty].
	^globals includesKey: anObject!

objectIsLiteral: anObject 
	"Private - Override hook for the STL filter"

	^false!

override: anObject with: anObjectToSave
	"This is an opportunity circumvent the running of anObject's #stbSaveOn: method by
	pre-specifying the required behaviour. The possible actions depend on the value of anObjectToSave.
	If anObjectToSave is:
		0
			This will cause anObject to be output as normal (ie. with no proxy).
		nil
			This will cause nil to be output in place of anObject.
		an STBProxy
			This will be output in place of the receiver. It will be sent a #fixup:at:
			message at load time and should then answer the object it represents."

	anObject isNil ifFalse: [proxyOverrides at: anObject put: anObjectToSave]!

putGlobal: anObject 
	"Private - Wrap anObject up as an STBGlobalObjectProxy and output that instead."

	| symbol |
	anObject isNil 
		ifTrue: [symbol := globalNils removeFirst]
		ifFalse: 
			[| symbolCollection |
			symbolCollection := globals at: anObject.
			symbol := symbolCollection removeFirst.
			symbolCollection isEmpty ifTrue: [globals removeKey: anObject]].
	self basicNextPut: (STBGlobalObjectProxy for: anObject name: symbol)!

putLiteral: anObject
	self shouldNotImplement!

refForObject: anObject
	"Private - Answer the map index of anObject or nil if it is not present.
	The nil object has a conceptual index of zero." 

	anObject isNil
		ifTrue: [^0].

	^writeMap at: anObject ifAbsent: []!

register: anObject
	"Private - Add anObject to the map of output objects."

	writeMap at: anObject put: writeMap size + refOffset!

register: anObject asGlobal: aSymbol
	"Add anObject to the globals dictionary.
	When this object is output it will be wrapped in an STBGlobalObjectProxy.
	When the proxy is subsequently loaded it be added to Smalltalk with the
	name aSymbol. If the same object is registered as several global symbols
	then it must be #nextPut: a corresponding number of times." 

	(anObject isNil
		ifTrue: [globalNils]
		ifFalse: [globals at: anObject ifAbsentPut: [OrderedCollection new]]) add: aSymbol!

reset
	"Private - Reset the instance.
	Write the fixed-format header to stream. This enables the reader to identify
	the version of the written data."

	refOffset := 1.
	writeMap := IdentityDictionary new: 128.
	globals := IdentityDictionary new: 8.
	globalNils := OrderedCollection new: 8.
	proxyOverrides := IdentityDictionary new.
	self resetStream.
	super reset!

resetStream
	stream
		nextPutAll: self class signature;
		nextPutAll: self class version displayString asByteArray;
		nextPut: Character space codePoint!

saveObject: aNonImmediateObject
	"Write anObject to the stream in STB format as normal.
	Note that the argument must NOT be a SmallInteger or other immediate object,
	neither should it be another 'special' object such as nil.
	This is a low-level method, and is not intended for normal binary object streaming - 
	use #nextPut: instead."

	self writeObject: aNonImmediateObject as: aNonImmediateObject withPrefix: STBPrefix forData!

saveObject: anObject as: anObjectToSave
	"Write anObject to the stream in STB format as anObjectToSave."

	"If anObjectToSave is zero then output anObject as normal (ie. without any proxy)."
	anObjectToSave == 0
		ifTrue: [^self saveObject: anObject].

	"A proxy of nil means output nil instead of anObject."
	anObjectToSave isNil
		ifTrue: [^self basicNextPut: nil].

	"Output anObject to save instead of anObject marking it as a proxy so the STBInFiler
	knows to do a #fixup:to on input."
	self writeObject: anObject as: anObjectToSave withPrefix: STBPrefix forProxy!

setRefOffset: anInteger
	refOffset := anInteger - writeMap size + 1!

writeClass: anObject withLocator: locatorString 
	stream nextPutAll: locatorString asByteArray!

writeClass: class withPrefix: anSTBPrefix 
	"Private - An object of the <Class>, class, is about to be written to the binary stream,
	output an appropriate class prefix for it."

	(self refForObject: class) 
		ifNotNil: 
			[:refIndex | 
			"class has already been output 	so we can encode a short reference to the class within the prefix."
			self writeInteger: (anSTBPrefix classRef: refIndex) dword]
		ifNil: 
			["hitherto unencountered class so we need to save full class details in the object header."
			| classVersion locatorString |
			locatorString := class name asString.
			self writeInteger: (anSTBPrefix class: class locator: locatorString) dword.
			(classVersion := class stbVersion) ~~ 0 ifTrue: [self writeInteger: classVersion].
			self writeClass: class withLocator: locatorString.
			self register: class]!

writeInstanceVariables: objectToSave 
	"Private - Dump the instance variables of the <Object> argument to the binary stream."

	| class basicSize |
	class := objectToSave basicClass.
	basicSize := objectToSave basicSize.
	class isVariable ifTrue: [self writeInteger: basicSize].
	class isBytes 
		ifTrue: 
			["#1132: Temp patch for rare 4-byte STB corruption"
			1 to: basicSize do: [:i | stream nextPut: (objectToSave basicAt: i)]
			"stream next: basicSize putAll: objectToSave yourAddress asExternalAddress startingAt: 1"]
		ifFalse: [1 to: class instSize + basicSize do: [:i | self basicNextPut: (objectToSave instVarAt: i)]]!

writeInteger: anInteger
	"Private - Write anInteger to the stream."

	stream nextSDWORDPut: anInteger!

writeObject: anObject as: objectToSave withPrefix: anSTBPrefix
	"Private - Represent anObject on the stream as objectToSave giving it a prefix of anSTBPrefix."

	self 
		writeClass: objectToSave class withPrefix: anSTBPrefix;
		register: anObject;
		writeInstanceVariables: objectToSave!

writePreambleFor: anObject 
	"Write the normal STB pre-amble for anObject to the output stream. The object is also
	registered in the write map so that any subsequent refs are shared. This method is intended
	for use from custom implementations of the class side #stbSaveOn: message."

	self
		writeClass: anObject class withPrefix: STBPrefix forData;
		register: anObject! !
!STBOutFiler categoriesFor: #basicNextPut:!accessing!private! !
!STBOutFiler categoriesFor: #nextPut:!operations!public! !
!STBOutFiler categoriesFor: #objectIsGlobal:!globals!private! !
!STBOutFiler categoriesFor: #objectIsLiteral:!helpers!private! !
!STBOutFiler categoriesFor: #override:with:!proxies!public! !
!STBOutFiler categoriesFor: #putGlobal:!globals!private! !
!STBOutFiler categoriesFor: #putLiteral:!helpers!private! !
!STBOutFiler categoriesFor: #refForObject:!private!searching! !
!STBOutFiler categoriesFor: #register:!accessing!private! !
!STBOutFiler categoriesFor: #register:asGlobal:!globals!public! !
!STBOutFiler categoriesFor: #reset!initializing!private! !
!STBOutFiler categoriesFor: #resetStream!initializing!private! !
!STBOutFiler categoriesFor: #saveObject:!operations!public! !
!STBOutFiler categoriesFor: #saveObject:as:!operations!public! !
!STBOutFiler categoriesFor: #setRefOffset:!accessing!private! !
!STBOutFiler categoriesFor: #writeClass:withLocator:!operations!private! !
!STBOutFiler categoriesFor: #writeClass:withPrefix:!operations!private! !
!STBOutFiler categoriesFor: #writeInstanceVariables:!operations!private! !
!STBOutFiler categoriesFor: #writeInteger:!helpers!private! !
!STBOutFiler categoriesFor: #writeObject:as:withPrefix:!operations!private! !
!STBOutFiler categoriesFor: #writePreambleFor:!binary filing!public! !

