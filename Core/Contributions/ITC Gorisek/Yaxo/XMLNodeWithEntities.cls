"Filed out from Dolphin Smalltalk X6.2"!

XMLNode subclass: #XMLNodeWithEntities
	instanceVariableNames: 'entities'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
XMLNodeWithEntities guid: (GUID fromString: '{3A3489A9-1660-4041-AD01-203DC0006B3C}')!
XMLNodeWithEntities comment: ''!
!XMLNodeWithEntities categoriesForClass!XML-Parser! !
!XMLNodeWithEntities methodsFor!

addEntity: entity
	self addEntity: entity name value: entity!

addEntity: entityName value: entityValue
	self entities add: entityName->entityValue!

elements
	^self entities collect: [:each | each value]!

entities
	entities ifNil: [entities := OrderedCollection new].
	^entities!

entitiesDo: aBlock
	#swYAXO.
	entities ifNotNil: 
			[:t | 
			"sw squeak expects monadic"

			self entities do: [:each | aBlock value: each key value: each value]]!

entityAt: entityName
	^self entityAt: entityName ifAbsent: [nil]!

entityAt: entityName ifAbsent: aBlock
	^(entities detect: [:each | each key = entityName] ifNone: [^aBlock value]) value!

printXMLOn: writer
	self entitiesDo: [:eName :eValue | eValue printXMLOn: writer]!

topElement
	^self entities first value! !
!XMLNodeWithEntities categoriesFor: #addEntity:!accessing!public! !
!XMLNodeWithEntities categoriesFor: #addEntity:value:!accessing!public! !
!XMLNodeWithEntities categoriesFor: #elements!accessing!public! !
!XMLNodeWithEntities categoriesFor: #entities!accessing!public! !
!XMLNodeWithEntities categoriesFor: #entitiesDo:!enumerating!public! !
!XMLNodeWithEntities categoriesFor: #entityAt:!accessing!public! !
!XMLNodeWithEntities categoriesFor: #entityAt:ifAbsent:!accessing!public! !
!XMLNodeWithEntities categoriesFor: #printXMLOn:!printing!public! !
!XMLNodeWithEntities categoriesFor: #topElement!accessing!public! !

