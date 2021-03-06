"Filed out from Dolphin Smalltalk 7"!

TestCase subclass: #RefactoringBrowserTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
RefactoringBrowserTest guid: (GUID fromString: '{89B8C31B-39F7-49C7-BD85-3B0C202CCF98}')!
RefactoringBrowserTest comment: 'SUnitBrowser openOnTestCase: self'!
!RefactoringBrowserTest categoriesForClass!Refactory-Testing! !
!RefactoringBrowserTest methodsFor!

convertInterval: anInterval for: aString 
	| startOffset stopOffset index |
	startOffset := 0.
	index := 1.
	
	[index < (anInterval first + startOffset) 
		and: [index + startOffset <= aString size]] 
			whileTrue: 
				[(aString at: index + startOffset) == Character lf
					ifTrue: [startOffset := startOffset + 1]
					ifFalse: [index := index + 1]].
	stopOffset := startOffset.
	
	[index < (anInterval last + startOffset) 
		and: [index + stopOffset <= aString size]] 
			whileTrue: 
				[(aString at: index + stopOffset) == Character lf
					ifTrue: [stopOffset := stopOffset + 1]
					ifFalse: [index := index + 1]].
	^anInterval first + startOffset to: anInterval last + stopOffset!

executeRefactoring: aRefactoring 
	aRefactoring primitiveExecute.
	RBParser parseExpression: aRefactoring storeString!

objectClassVariable
	^Object classPool keys detect: [:each | true]!

proceedThroughWarning: aBlock 
	#rbFix. "Use ANSI standard #resume"
"	aBlock on: RefactoringWarning do: [:ex | ex proceed]"
	aBlock on: RefactoringWarning do: [:ex | ex resume]
! !
!RefactoringBrowserTest categoriesFor: #convertInterval:for:!private! !
!RefactoringBrowserTest categoriesFor: #executeRefactoring:!private! !
!RefactoringBrowserTest categoriesFor: #objectClassVariable!private! !
!RefactoringBrowserTest categoriesFor: #proceedThroughWarning:!private! !

!RefactoringBrowserTest class methodsFor!

isAbstract
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^self == ##(self)!

shouldInheritSelectors
	"answer true to inherit selectors from superclasses"

	^false! !
!RefactoringBrowserTest class categoriesFor: #isAbstract!public!Testing! !
!RefactoringBrowserTest class categoriesFor: #shouldInheritSelectors!public!Testing! !

