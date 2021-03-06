"Filed out from Dolphin Smalltalk 7"!

SearchPolicyTest subclass: #AlwaysSearchPolicyTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AlwaysSearchPolicyTest guid: (GUID fromString: '{260ACD79-36CB-42B0-B7FF-86B9991EBE0F}')!
AlwaysSearchPolicyTest comment: ''!
!AlwaysSearchPolicyTest categoriesForClass!Unclassified! !
!AlwaysSearchPolicyTest methodsFor!

policyClass
	^AlwaysSearchPolicy!

testCompareWith
	self assert: (policy compare: false with: false).
	self assert: (policy compare: false with: true).
	self assert: (policy compare: true with: false).
	self assert: (policy compare: true with: true).
	self assert: (policy compare: 'a' with: 'a').
	self assert: (policy compare: 'a' with: 'A').
	self assert: (policy compare: 'a' with: 'b').
	self assert: (policy compare: 1 with: 1).
	self assert: (policy compare: 1 with: 2).
	self assert: (policy compare: 2 with: 1).
	self assert: (policy compare: nil with: nil).
	self assert: (policy compare: Object new with: Object new).
	self assert: (policy compare: #hash with: #hash).
	self assert: (policy compare: #hash with: #identityHash).
	self assert: (policy compare: $a with: $a).
	self assert: (policy compare: $a with: $b)! !
!AlwaysSearchPolicyTest categoriesFor: #policyClass!private!unit tests! !
!AlwaysSearchPolicyTest categoriesFor: #testCompareWith!public!unit tests! !

