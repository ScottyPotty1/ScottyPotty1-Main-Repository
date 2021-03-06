"Filed out from Dolphin Smalltalk X6"!

ClassBrowserPlugin subclass: #SmalllintPlugin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SmalllintPlugin guid: (GUID fromString: '{321FCBFB-84D2-40AE-BF8F-F4B816723A1B}')!
SmalllintPlugin comment: ''!
!SmalllintPlugin categoriesForClass!MVP-Presenters! !
!SmalllintPlugin methodsFor!

browserEnvironment
	^self browser selectionEnvironment!

checkerForRule: aLintRule environment: env 
	^(SmalllintChecker newWithCachingContext)
		rule: aLintRule;
		environment: env;
		yourself!

methodFilterForRule: aLintRule inEnvironment: aBrowserEnvironment 
	^
	[:method | 
	(aBrowserEnvironment includesMethod: method) and: 
			[(self checkerForRule: aLintRule
				environment: (SelectorEnvironment 
						onMethods: (Array with: method selector)
						forClass: method methodClass
						in: aBrowserEnvironment)) 
					run.
			aLintRule failedMethods notEmpty]]!

runRule: aLintRule 
	| checker env |
	env := self browserEnvironment.
	checker := self checkerForRule: aLintRule environment: env.
	^env numberClasses > 20 
		ifTrue: 
			[| progress |
			progress := ProgressDialog create.
			progress
				caption: 'Running Rule... ';
				text: aLintRule name.
			progress operation: 
					[:progressPresenter | 
					| checkedSoFar numberSelectors |
					numberSelectors := env numberSelectors.
					checkedSoFar := 0.
					checker
						methodBlock: 
								[checkedSoFar := checkedSoFar + 1.
								progressPresenter value: checkedSoFar / numberSelectors * 100];
						run].
			progress showModal]
		ifFalse: [Cursor wait showWhile: [checker run]]!

runTransformation: aTransformationRule 
	(self runRule: aTransformationRule) isNil 
		ifFalse: [RewriteChangesBrowser showOn: aTransformationRule changes]!

status: text 
	^self browser statusText: text!

systemModel
	"Private - Answer the development system model."

	^Smalltalk developmentSystem! !
!SmalllintPlugin categoriesFor: #browserEnvironment!operations!private! !
!SmalllintPlugin categoriesFor: #checkerForRule:environment:!helpers!private! !
!SmalllintPlugin categoriesFor: #methodFilterForRule:inEnvironment:!helpers!private! !
!SmalllintPlugin categoriesFor: #runRule:!helpers!private! !
!SmalllintPlugin categoriesFor: #runTransformation:!helpers!private! !
!SmalllintPlugin categoriesFor: #status:!operations!private! !
!SmalllintPlugin categoriesFor: #systemModel!commands!private! !

!SmalllintPlugin class methodsFor!

isAbstract
	^self == ##(self)! !
!SmalllintPlugin class categoriesFor: #isAbstract!public!Testing! !

