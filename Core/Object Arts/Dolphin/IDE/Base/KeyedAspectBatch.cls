"Filed out from Dolphin Smalltalk 7"!

KeyedAspect subclass: #KeyedAspectBatch
	instanceVariableNames: 'batchSize keys accessorClass'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
KeyedAspectBatch guid: (GUID fromString: '{0F7D3EFE-6F95-4DE3-A5E1-2EC7A86EB8B2}')!
KeyedAspectBatch comment: 'Part of the PublishedAspectorInspector framework.<KeyedAspectBatch> instances are used to describe a group of <KeyedAspects> of a keyed collection. Batching the keyed aspects up in this way via a <KeyedAspectBatchAccessor> allows the PAI to only display a certain number of elements at a time. This can substantially improve performance when displaying large (or slow to access) collections.'!
!KeyedAspectBatch categoriesForClass!Development! !
!KeyedAspectBatch methodsFor!

accessorClass
	^accessorClass!

batchSize
	"Answers the batch size of the receiver, i.e. the number of keyed elements to return at a time"

	^batchSize!

keys
	^keys!

readFrom: anObject

	^'next ', batchSize printString, ' items'!

setKeys: aSequencedReadableCollection batchSize: anInteger accessorClass: aClass 
	keys := aSequencedReadableCollection.
	batchSize := anInteger.
	accessorClass := aClass! !
!KeyedAspectBatch categoriesFor: #accessorClass!constants!public! !
!KeyedAspectBatch categoriesFor: #batchSize!accessing!public! !
!KeyedAspectBatch categoriesFor: #keys!accessing!public! !
!KeyedAspectBatch categoriesFor: #readFrom:!public! !
!KeyedAspectBatch categoriesFor: #setKeys:batchSize:accessorClass:!private! !

!KeyedAspectBatch class methodsFor!

keys: aSequencedReadableCollection startingAt: startInteger batchSize: sizeInteger accessorClass: aClass 
	"Answer an instance of the receiver created with aKey"

	^(super key: startInteger)
		setKeys: aSequencedReadableCollection
			batchSize: sizeInteger
			accessorClass: aClass;
		yourself! !
!KeyedAspectBatch class categoriesFor: #keys:startingAt:batchSize:accessorClass:!public! !

