"Filed out from Dolphin Smalltalk 7"!

DolphinTest subclass: #BlockClosureTest
	instanceVariableNames: 'x'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BlockClosureTest guid: (GUID fromString: '{346B84AA-D94E-4EE6-9461-5195EF00255B}')!
BlockClosureTest comment: ''!
!BlockClosureTest categoriesForClass!Unclassified! !
!BlockClosureTest methodsFor!

nestedReturn
	"Not actually a far return, therefore no method context needed"
	^[
	[x := 1.
	1] ensure: 
				[x := x + 1.
				2]] ensure: 
			[x := x + 1.
			3]!

nestedReturn1
	"Far return from protected block, therefore needs context, and protected block needs outer ref"
	^[
	[x := 1.
	^1] ensure: 
				[x := x + 1.
				2]] ensure: 
			[x := x + 1.
			3]!

nestedReturn2
	^[
	[x := 1.
	^1] ensure: 
				[x := x + 1.
				^2]] ensure: 
			[x := x + 1.
			3]!

nestedReturn3
	^[
	[x := 1.
	^1] ensure: 
				[x := x + 1.
				^2]] ensure: 
			[x := x + 1.
			^3]!

testCopyingBlock
	| blocks result |
	blocks := OrderedCollection new.
	1 to: 10 do: [:i | blocks add: [i]].
	1 to: blocks size
		do: 
			[:i | 
			| block |
			block := blocks at: i.
			self assert: block argumentCount = 0.
			self assert: block size = 1.
			self assert: block outer isNil.
			self assert: block value = i].
	result := blocks inject: 0
				into: 
					[:sum :each | 
					sum + each value].
	"If blocks working correctly, then the closed over variable 'i', should have a different value in each block,
	and so the result should be the sum of numbers up to 10"
	self assert: result = ((1 to: 10) inject: 0 into: [:sum :each | sum + each])!

testCull	[  ] cull: 1.	[ :x |  ] cull: 1.	self should: [ [ :x :y |  ] cull: 1 ] raise: Error.	self should: [ [ :x :y :z |  ] cull: 1 ] raise: Error.	self should: [ [ :x :y :z :a |  ] cull: 1 ] raise: Error.	self should: [ [ :x :y :z :a :b |  ] cull: 1 ] raise: Error.	self assert: ([ 0 ] cull: 1) = 0.	self assert: ([ :x | x ] cull: 1) = 1!

testCullCull	[  ] cull: 1 cull: 2.	[ :x |  ] cull: 1 cull: 2.	[ :x :y |  ] cull: 1 cull: 2.	self should: [ [ :x :y :z |  ] cull: 1 cull: 2 ] raise: Error.	self should: [ [ :x :y :z :a |  ] cull: 1 cull: 2 ] raise: Error.	self should: [ [ :x :y :z :a :b |  ] cull: 1 cull: 2 ] raise: Error.	self assert: ([ 0 ] cull: 1 cull: 2) = 0.	self assert: ([ :x | x ] cull: 1 cull: 2) = 1.	self assert: ([ :x :y | y ] cull: 1 cull: 2) = 2!

testCullCullCull	[  ] cull: 1 cull: 2 cull: 3.	[ :x |  ] cull: 1 cull: 2 cull: 3.	[ :x :y |  ] cull: 1 cull: 2 cull: 3.	[ :x :y :z |  ] cull: 1 cull: 2 cull: 3.	self should: [ [ :x :y :z :a |  ] cull: 1 cull: 2 cull: 3 ] raise: Error.	self should: [ [ :x :y :z :a :b |  ] cull: 1 cull: 2 cull: 3 ] raise: Error.	self assert: ([ 0 ] cull: 1 cull: 2 cull: 3) = 0.	self assert: ([ :x | x ] cull: 1 cull: 2 cull: 3) = 1.	self assert: ([ :x :y | y ] cull: 1 cull: 2 cull: 3) = 2.	self assert: ([ :x :y :z | z ] cull: 1 cull: 2 cull: 3) = 3!

testCullCullCullCull	[  ]		cull: 1		cull: 2		cull: 3		cull: 4.	[ :x |  ]		cull: 1		cull: 2		cull: 3		cull: 4.	[ :x :y |  ]		cull: 1		cull: 2		cull: 3		cull: 4.	[ :x :y :z |  ]		cull: 1		cull: 2		cull: 3		cull: 4.	[ :x :y :z :a |  ]		cull: 1		cull: 2		cull: 3		cull: 4.	self		should: [ 			[ :x :y :z :a :b |  ]				cull: 1				cull: 2				cull: 3				cull: 4 ]		raise: Error.	self		assert:			([ 0 ]				cull: 1				cull: 2				cull: 3				cull: 4) = 0.	self		assert:			([ :x | x ]				cull: 1				cull: 2				cull: 3				cull: 4) = 1.	self		assert:			([ :x :y | y ]				cull: 1				cull: 2				cull: 3				cull: 4) = 2.	self		assert:			([ :x :y :z | z ]				cull: 1				cull: 2				cull: 3				cull: 4) = 3.	self		assert:			([ :x :y :z :a | a ]				cull: 1				cull: 2				cull: 3				cull: 4) = 4!

testEmptyBlock
	(Array
		with: []
		with: [:a | ]
		with: [:a :b | ]) do: 
				[:each |
				self assert: (each valueWithArguments: (1 to: each argumentCount) asArray) isNil.
				true
					ifTrue: 
						[self assert: each outer isNil.
						self assert: each receiver isNil]]!

testEnsure
	self assert: self nestedReturn = 1.
	self assert: x = 3.
	self assert: self nestedReturn1 = 1.
	self assert: x = 3.
	self assert: self nestedReturn2 = 2.
	self assert: x = 3.
	self assert: self nestedReturn3 = 3.
	self assert: x = 3!

testNesting
	| a b c |
	a := 
			[:x1 |
			b := 
					[:x2 |
					c := [:x3 | x3 * x3].
					x2 * (c value: x2 + 1)].
			x1 * (b value: x1 + 1)].
	self assert: (a value: 1) = (1 * (2 * (3 * 3))).

	"a should be a full block, as it assigns method level temps"
	self assert: (a outer isKindOf: self methodContextClass).
	"All the shared temps are allocated at the method level"
	self assert: b outer == a outer.
	true
		ifTrue: 
			["C doesn't need an outer as it only refs its argument"
			self assert: c outer isNil]!

testNoArguments
	self 
		should: [:arg | arg]
		raise: Error
		matching: [:err | err description = 'Block expects 1 argument(s)'].
	self 
		should: [:arg1 :arg2 | arg1 + arg2]
		raise: Error
		matching: [:err | err description = 'Block expects 2 argument(s)']!

testOneArgument
	| c |
	c := OrderedCollection new.
	c add: 'hello'.
	self 
		should: [c do: [1 + 2]]
		raise: Error
		matching: [:err | err description = 'Block expects 0 argument(s)'].
	self 
		should: [c do: [:arg1 :arg2 | 1 + 2]]
		raise: Error
		matching: [:err | err description = 'Block expects 2 argument(s)']!

testRecursiveBlock
	| factorial |
	factorial := [:int | int > 1 ifTrue: [(factorial value: int - 1) * int] ifFalse: [1]].
	"factorial itself is a shared temp, so the block must have an outer"
	self assert: factorial outer notNil.
	"factorial should have one arg"
	self assert: factorial argumentCount = 1.
	"factorial requires no extra stack temps"
	self assert: factorial stackTempCount = 0.
	"factorial block itself has no copied values or shared temps of its own"
	self assert: factorial size = 0.
	self assert: (factorial value: 6) = 720!

testValueWithArguments
	| hash |
	hash := self identityHash.
	
	[:a | 
	self assert: self identityHash = hash.
	self assert: a == 1] valueWithArguments: #(1).
	
	[:a :b | 
	self assert: self identityHash = hash.
	self assert: a == 1.
	self assert: b == 2] 
			valueWithArguments: #(1 2).
	
	[:a :b :c | 
	self assert: self identityHash = hash.
	self assert: a == 1.
	self assert: b == 2.
	self assert: c == 3] 
			valueWithArguments: #(1 2 3).
	
	[:a :b :c :d | 
	self assert: self identityHash = hash.
	self assert: a == 1.
	self assert: b == 2.
	self assert: c == 3.
	self assert: d == 4] 
			valueWithArguments: #(1 2 3 4).
	self should: [[3 + 4] valueWithArguments: #(1)] raise: Error.
	self shouldnt: [[3 + 4] valueWithArguments: #()] raise: Error.
	self 
		should: [[3 + 4] valueWithArguments: #(1)]
		raise: Error
		matching: [:err | err description = 'Block expects 0 argument(s)'].
	self 
		should: [[:i | 3 + 4] valueWithArguments: #(1 2)]
		raise: Error
		matching: [:err | err description = 'Block expects 1 argument(s)']! !
!BlockClosureTest categoriesFor: #nestedReturn!helpers!private! !
!BlockClosureTest categoriesFor: #nestedReturn1!helpers!private! !
!BlockClosureTest categoriesFor: #nestedReturn2!helpers!private! !
!BlockClosureTest categoriesFor: #nestedReturn3!helpers!private! !
!BlockClosureTest categoriesFor: #testCopyingBlock!public!unit tests! !
!BlockClosureTest categoriesFor: #testCull!public!tests / evaluating! !
!BlockClosureTest categoriesFor: #testCullCull!public!tests / evaluating! !
!BlockClosureTest categoriesFor: #testCullCullCull!public!tests / evaluating! !
!BlockClosureTest categoriesFor: #testCullCullCullCull!public!tests / evaluating! !
!BlockClosureTest categoriesFor: #testEmptyBlock!public!unit tests! !
!BlockClosureTest categoriesFor: #testEnsure!public!unit tests! !
!BlockClosureTest categoriesFor: #testNesting!public!unit tests! !
!BlockClosureTest categoriesFor: #testNoArguments!public!unit tests! !
!BlockClosureTest categoriesFor: #testOneArgument!public!unit tests! !
!BlockClosureTest categoriesFor: #testRecursiveBlock!public!unit tests! !
!BlockClosureTest categoriesFor: #testValueWithArguments!public!unit tests! !

