"Filed out from Dolphin Smalltalk 7"!

WeakArray variableSubclass: #WeakAnnouncementSubscription
	instanceVariableNames: 'announcer announcementClass action'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
WeakAnnouncementSubscription guid: (GUID fromString: '{D0E41596-8781-40BB-97FB-9EA63E7E7698}')!
WeakAnnouncementSubscription comment: 'A WeakAnnouncementSubscription is a subscription which is removed automatically when the subscriber is unreferenced.No support for ephemerons currently prevents this from working for Block actions (blocks hold their receiver, which is the default subscriber strongly). To switch between subscription types, use makeStrong/makeWeak on the subscription returned when initially registering with announcer.Note, that list and next must be first instance variables.'!
!WeakAnnouncementSubscription categoriesForClass!Announcements-Core! !
!WeakAnnouncementSubscription methodsFor!

action	^ action!

action: anObject	action := anObject!

announcementClass	^ announcementClass!

announcementClass: anObject	announcementClass := anObject!

announcer	^ announcer!

announcer: anAnnouncer	announcer := anAnnouncer!

deliver: anAnnouncement 
	"Deliver an announcement to receiver. In case of failure"

	^(self handlesAnnouncement: anAnnouncement) ifTrue: [action cull: anAnnouncement cull: announcer]!

handlesAnnouncement: anAnnouncement	self nilCorpsesAndDo: [:index | ].	^ (announcementClass handlesAnnouncement: anAnnouncement) and: [self subscriber notNil ]!

makeStrong	| sub |	sub := self subscriber.	sub ifNil: [ ^ self error: 'Subscriber is nil, cannot make strong subscription' ].		^ announcer replace: self with: 		(AnnouncementSubscription new			announcer: announcer;			action: action asMessageSend;			subscriber: sub;			announcementClass: announcementClass)!

makeWeak	^ self!

subscriber	^ self basicAt: 1!

subscriber: anObject	self subscriber ifNotNil: [ self error: 'subscriber already set' ].	self basicAt: 1 put: anObject!

valuable: aValuable	"Used when subscriber should be extracted from valuable object"	self action:  aValuable.	self subscriber: aValuable receiver.! !
!WeakAnnouncementSubscription categoriesFor: #action!accessing!public! !
!WeakAnnouncementSubscription categoriesFor: #action:!accessing!public! !
!WeakAnnouncementSubscription categoriesFor: #announcementClass!accessing!public! !
!WeakAnnouncementSubscription categoriesFor: #announcementClass:!accessing!public! !
!WeakAnnouncementSubscription categoriesFor: #announcer!accessing!public! !
!WeakAnnouncementSubscription categoriesFor: #announcer:!accessing!public! !
!WeakAnnouncementSubscription categoriesFor: #deliver:!announcing!public! !
!WeakAnnouncementSubscription categoriesFor: #handlesAnnouncement:!error handling!public! !
!WeakAnnouncementSubscription categoriesFor: #makeStrong!converting!public! !
!WeakAnnouncementSubscription categoriesFor: #makeWeak!converting!public! !
!WeakAnnouncementSubscription categoriesFor: #subscriber!accessing!public! !
!WeakAnnouncementSubscription categoriesFor: #subscriber:!accessing!public! !
!WeakAnnouncementSubscription categoriesFor: #valuable:!accessing!public! !

!WeakAnnouncementSubscription class methodsFor!

new
	^super new: 1! !
!WeakAnnouncementSubscription class categoriesFor: #new!public! !

