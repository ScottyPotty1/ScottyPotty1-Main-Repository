"Filed out from Dolphin Smalltalk 7"!

DolphinTest subclass: #FalseTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FalseTest guid: (GUID fromString: '{99F97009-5267-45FD-913E-D80674F965FA}')!
FalseTest comment: 'This is the unit test for the class False. Unit tests are a good way to exercise the functionality of your system in a repeatable and automatic manner. They are therefore recommended if you plan to release anything. For more information, see: 
	- http://www.c2.com/cgi/wiki?UnitTest
	- http://minnow.cc.gatech.edu/squeak/1547
	- the sunit class category
'!
!FalseTest categoriesForClass!Tests-Kernel-Objects! !
!FalseTest methodsFor!

testAnd
	self assert: (false and: ['alternativeBlock']) = false!

testAND
	self assert: (false & true) = false.
	self assert: (false & false) = false!

testIfFalse
	self should: [(false ifFalse: ['alternativeBlock']) = 'alternativeBlock']!

testIfFalseIfTrue
	self assert: (false ifFalse: ['falseAlternativeBlock'] ifTrue: ['trueAlternativeBlock']) 
				= 'falseAlternativeBlock'!

testIfTrue
	self assert: (false ifTrue: ['alternativeBlock']) = nil!

testIfTrueIfFalse
	self assert: (false ifTrue: ['trueAlternativeBlock'] ifFalse: ['falseAlternativeBlock']) 
				= 'falseAlternativeBlock'!

testNew
	self should: [False new] raise: TestResult error!

testNot
	self should: [false not = true]!

testOr
 self assert: (false or: ['alternativeBlock']) = 'alternativeBlock'.!

testOR
	self assert: (false | true) = true.
	self assert: (false | false) = false!

testPrintOn
	| stream |
	stream := String writeStream.
	false printOn: stream.
	self assert: stream contents = 'false'! !
!FalseTest categoriesFor: #testAnd!public!testing! !
!FalseTest categoriesFor: #testAND!public!testing! !
!FalseTest categoriesFor: #testIfFalse!public!testing! !
!FalseTest categoriesFor: #testIfFalseIfTrue!public!testing! !
!FalseTest categoriesFor: #testIfTrue!public!testing! !
!FalseTest categoriesFor: #testIfTrueIfFalse!public!testing! !
!FalseTest categoriesFor: #testNew!public!testing! !
!FalseTest categoriesFor: #testNot!public!testing! !
!FalseTest categoriesFor: #testOr!public!testing! !
!FalseTest categoriesFor: #testOR!public!testing! !
!FalseTest categoriesFor: #testPrintOn!public!testing! !

