"Filed out from Dolphin Smalltalk 7"!

Object subclass: #FileLocator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FileLocator guid: (GUID fromString: '{391014F8-EBB8-4DD3-BD5D-FB6F303DE483}')!
FileLocator comment: 'A FileLocator is an abstract root for a hierarchy of subclasses that implement the <fileLocator> protocol. 
A <fileLocator> is used map between an external resource pathname and an internal name. First an external name is mapped to an internal form using #relativePathTo:. The latter can be held in the image and later mapped back to it''s is full external name using #localFileSpecFor:.

Several singleton <fileLocator>s are supplied and can be referenced using the following class methods:

#imageRelative	- An instance of ImageRelativeFileLocator
#installRelative	- An instance of InstallRelativeFileLocator
#absolute		- An instance od AbsoluteFileLocator
#default		- Answers the #imageRelative locator

For example, say that you want to reference an Icon resource file that is held relative to your current image file (perhaps in the \Resources sudirectory). You want to do this in such a way that if you move your image then the \Resources directory will be expected to move with it.

icon := Icon fromFile: ''Resources\myIcon.ico'' usingLocator: FileLocator imageRelative.

Here, the path to the icon file will be held within the Icon instance in a form that is relative to the base location of the image directory. Icons also hold the file locator too and use this to map back to the full path of the icon file when it is necessary to load it. Hence if you move your image file, the Icon will still expect to be able to load the icon resource from a location that relative to the image directory.

Typically, this is the behaviour that you''ll want by default. At development time, resources are referenced relative to the image and, at runtime, relative to the executable file (which is effective an image, anyway). For this reason the above example could also have been written as:

icon := Icon fromFile: ''Resources\myIcon.ico'' usingLocator: FileLocator default
or
icon := Icon fromFile: ''Resources\myIcon.ico'' 

Sometimes, especially in the case of development tools, you might want a resource to be referenced relative to the Dolphin installation directory. In this case an InstallRelativeFileLocator would be moe appropriate. Take a look at DolphinSureCertificate>>image, for example. Note that, at runtime, the image location and installation location are treated as the same by a standard RuntimeSessionManager.

Class Variables:
	Absolute		<AbsoluteFileLocator> instance used for locating files by absolute directory.
	InstallRelative	<InstallRelativeFileLocator> instance used for locating files relative to the installation directory.
	ImageRelative	<ImageRelativeFileLocator> instance used for locating files relative to the image directory.

'!
!FileLocator categoriesForClass!System-Support! !
!FileLocator methodsFor!

basePath
	^SessionManager current imageBase!

findOrImportForeignClass
	"An attempt is being made by a <ClassLocator> to load a class when the dynamic loading
	capability is not installed. This is normally available as part of the Web Deployment Kit.
	Raise an error to the effect that the class cannot be found."

	^self errorClassNotFound!

localFileSpecFor: aString 
	"Answer a full filespec for the <readableString> relative path argument, formed according to
	the rules of this particular file locator. This is the reverse operation to
	#relativePathTo:, and is performed when the file needs to be located."

	^File fullPathOf: aString relativeTo: self basePath!

relativePathIfSubPath: aFilename 
	"Private - Answer a minimal <readableString> relative path to the resource with the
	specified <readableString> path, but only if a sub-path of the receiver's base path,
	otherwise answer the full absolute path."

	| relative |
	relative := self relativeToBase: aFilename.
	^(relative beginsWith: '..') ifTrue: [File fullPathOf: aFilename] ifFalse: [relative]!

relativePathTo: aString 
	"Answer a minimal <readableString> relative path to the resource with the specified
	<readableString> path from the receiver's base path."

	^self relativeToBase: aString!

relativeToBase: aFilename 
	^File relativePathOf: aFilename to: self basePath! !
!FileLocator categoriesFor: #basePath!accessing!public! !
!FileLocator categoriesFor: #findOrImportForeignClass!operations!private! !
!FileLocator categoriesFor: #localFileSpecFor:!accessing!public! !
!FileLocator categoriesFor: #relativePathIfSubPath:!accessing!private! !
!FileLocator categoriesFor: #relativePathTo:!accessing!public! !
!FileLocator categoriesFor: #relativeToBase:!accessing!private! !

FileLocator methodProtocol: #fileLocator attributes: #(#readOnly) selectors: #(#localFileSpecFor: #relativePathTo:)!

!FileLocator class methodsFor!

absolute
	"Answers an instance of the receiver that can be used to locate external files
	with an absolute path."

	^AbsoluteFileLocator current
!

default
	"Answers an instance of the receiver that can be used to locate external files
	relative to the current image directory."

	^self imageRelative
!

imageRelative
	"Answers an instance of the receiver that can be used to locate external files
	relative to the current image  directory."

	^ImageRelativeFileLocator current!

imageRelative: aFilenameString
	^self imageRelative localFileSpecFor: aFilenameString
!

installRelative
	"Answers an instance of the receiver that can be used to locate external files
	relative to the current installation directory."

	^InstallRelativeFileLocator current
!

installRelative: aFilenameString
	^self installRelative localFileSpecFor: aFilenameString
! !
!FileLocator class categoriesFor: #absolute!accessing!public! !
!FileLocator class categoriesFor: #default!accessing!public! !
!FileLocator class categoriesFor: #imageRelative!accessing!public! !
!FileLocator class categoriesFor: #imageRelative:!accessing!public! !
!FileLocator class categoriesFor: #installRelative!accessing!public! !
!FileLocator class categoriesFor: #installRelative:!accessing!public! !

