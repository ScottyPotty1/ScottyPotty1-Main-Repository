"Filed out from Dolphin Smalltalk 7"!

Object subclass: #DolphinProduct
	instanceVariableNames: 'versionMask encryptedClasses'
	classVariableNames: 'Current EditionsMap'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
DolphinProduct guid: (GUID fromString: '{0BCC007B-10ED-40CE-940E-83882E2F70D8}')!
DolphinProduct comment: ''!
!DolphinProduct categoriesForClass!Development! !
!DolphinProduct methodsFor!

allPackages
	"Answer an <OrderedCollection> of Packages associated with the receiver. This includes
	all of the prerequisite packages that are required by the named packages
	of the receiver"

	| set |
	set := IdentitySet new.
	self packages do: 
			[:each | 
			set
				addAll: (self deepPrerequisitesOf: each);
				add: each].
	^set asOrderedCollection!

basicLoad
	"Private - Loads the required packages into the image for the receiver. 
	Does not remove any packages that should not be present"

	"Inform the development system of it's new product state"

	| packageManager |
	self installProductDetails.
	packageManager := Package manager.
	self packagePaths do: 
			[:each | 
			| name |
			name := File splitStemFrom: each.
			packageManager packageNamed: name
				ifNone: 
					[[packageManager install: each] on: packageManager prerequisiteNotFoundSignal
						do: [:ex | ex resume: (File splitPathFrom: each)]]].
	Smalltalk developmentSystem beNotChanged!

beCurrent
	"Sets the singleton instance which represents the current product level of this image
	to the receiver"

	Current := self!

boot
	self loadShrinkAndCompress.
	self installSystemFolderOptions.
	self installSplash

!

contents
	"Answer the list of package contents associated with the receiver. Each content item is a
	three element array containing the package path, a <Symbol> describing the encryption mode
	and a <Symbol> describing whether the package normally resides in the image or on disk after
	installation."

	| answer |
	answer := OrderedCollection new.
	"Some loaded by boot part 2 script"
	answer
		add: #('Core\Object Arts\Dolphin\Base\Dolphin.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\Base\Dolphin Base.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\System\Filer\Dolphin Literal Filer.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\Registry\Dolphin Registry Access.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\System\Base64\Dolphin Base64.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\System\Compiler\Smalltalk Parser.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\System\Recent\Dolphin Recent Menu.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Models\Value\Dolphin Value Models.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Type Converters\Dolphin Type Converters.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Base\Dolphin MVP Base.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Dialogs\Common\Dolphin Common Dialogs.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Dialogs\Common\Dolphin Common Print Dialog.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Text\Dolphin Text Presenter.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\Base\Dolphin Additional Sort Algorithms.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\List\Dolphin List Presenter.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Models\List\Dolphin List Models.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Choice\Dolphin Choice Presenter.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Views\Scrollbars\Dolphin Scrollbars.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Number\Dolphin Number Presenter.pax' #plain #imageBased);
		yourself.
	answer
		add: #('Core\Object Arts\Dolphin\MVP\Models\Tree\Dolphin Tree Models.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Tree\Dolphin Tree Presenter.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Boolean\Dolphin Boolean Presenter.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Views\Common Controls\Dolphin Common Controls.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Views\Control Bars\Dolphin Control Bars.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Views\Styled Views\Dolphin Styled Views.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Collection\Dolphin Collection Presenters.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Folder\Dolphin Folder Presenter.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Tree\Dolphin Tree List Presenter.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Accelerator\Dolphin Accelerator Presenter.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Font\Dolphin Font Presenter.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Image\Dolphin Image Presenter.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Views\MoenTree\Dolphin MoenTree View.pax' #plain #imageBased);
		yourself.
	"These views have to be loaded before the development system because they have #publishedAspects, etc, methods"
	answer
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Date Time\Dolphin Date Time Presenters.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Radio\Dolphin Radio Buttons.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Views\Date Time\Dolphin Date Time Controls.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Views\Slider\Dolphin Slider Control.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Views\SpinButton\Dolphin SpinButton Control.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Views\Tooltips\Dolphin Tooltips.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Views\Cards\Dolphin Card Containers.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Color\Dolphin Color Presenter.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Views\Scintilla\Dolphin Scintilla View.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Dialogs\Find\Dolphin Find Dialog.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Views\Sliding Tray\Dolphin Slidey-Inney-Outey Thing.pax' #plain #imageBased);
		yourself.

	"Load up the Transcript - still dependent upon RichTextEdit at present"
	answer
		add: #('Core\Object Arts\Dolphin\MVP\Dialogs\Progress\Dolphin Progress Dialog.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\MVP\Presenters\Text\Dolphin Rich Text Presenter.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\IDE\Base\Dolphin Transcript.pax' #plain #imageBased);
		yourself.

	"The development system itself"
	answer
		add: #('Core\Object Arts\Dolphin\System\Trace\Debug Trace Stream.pax' #plain #imageBased);
		add: #('Core\Contributions\Refactory\Refactoring Browser\Parser\RBParser.pax' #plain #imageBased);
		add: #('Core\Contributions\Refactory\Refactoring Browser\Environments\RBEnvironments.pax' #plain #imageBased);
		add: #('Core\Contributions\Refactory\Refactoring Browser\Change Objects\RBChangeObjects.pax' #plain #imageBased);
		add: #('Core\Object Arts\Dolphin\IDE\Base\Development System.pax' #plain #imageBased);
		yourself.

	"Hmmm, try and break dependency of Installation Manager on the development system"
	answer
		add: #('Core\Object Arts\Internal\Installation Manager\Dolphin Products.pax' #plain #imageBased);
		yourself.
	^answer!

deepPrerequisitesOf: aPackage 
	"Private - Answers an IdentitySet of packages that are the deep prerequisites of aPackage"

	| prereqs deepPrereqs |
	prereqs := aPackage prerequisites.
	deepPrereqs := IdentitySet new.
	deepPrereqs addAll: prereqs.
	prereqs do: [:each | deepPrereqs addAll: (self deepPrerequisitesOf: each)].
	^deepPrereqs!

diskBasedPackages
	"Private - Answer the list of package names associated with the receiver that are intended to be disk based"

	| paths |
	paths := self contents reject: [:each | (each at: 3) == #imageBased].
	^paths collect: [:each | File splitStemFrom: (each at: 1)]!

displayOn: aStream
	"Append a textual representation of the receiver to the <puttableStream> argument
	as a user might want to see it."

	aStream
		display: self fullName;
		space;
		display: self version!

encryptedClasses
	"Answer classes owned by the receiver that will be encrypted in the deployed executable."

	encryptedClasses isNil 
		ifTrue: 
			[| packages classes |
			packages := self encryptedPackageNames collect: [:each | Package manager packageNamed: each].
			classes := Set new.
			packages do: [:each | classes addAll: each classes].
			classes := classes asArray select: [:each | self isSafeToEncrypt: each].
			self shouldEncryptMetaclasses 
				ifTrue: [classes := classes , (classes collect: [:each | each class])].
			encryptedClasses := classes asSortedCollection: [:a :b | (a name trueCompare: b name) <= 0]].
	^encryptedClasses!

encryptedClasses: aCollectionOfClasses
	"Private - Record which classes we should encrypt during deployment (this is called
	from #initialise with a list of classes derived from #encryptedPackageNames)."

	encryptedClasses := aCollectionOfClasses.!

encryptedPackageNames
	"Answer a <Set> of Package names associated with the receiver that must be encrypted
	when the receiver is installed"

	| encrypted |
	encrypted := self contents select: [:each | (each at: 2) == #encrypted].
	^encrypted collect: [:each | File splitStemFrom: (each at: 1)]!

foldLiterals
	Class foldLiteralStrings!

fullName
	"Answer the full product name associated with the receiver"

	^self subclassResponsibility!

imageLevel
	"Answer the <Integer> imageLevel for this product in this version of Dolphin"

	^(self versionMask << 8) | self class productMask!

installProductDetails
	"Private - Informs the development system of the details of the receiver" 

	SessionManager current productDetails: self productDetails
!

installProductSounds
	"Private - Installs the sounds scheme for the receiver" 

	Sound clearRegistry.!

installSplash
	"Use the default"!

isSafeToEncrypt: aClass
	"Private -- Answer whether it is safe to encrypt the given class.
	Classes that must not be encrypted are this session manager's
	class, our serial number class, and our product protection class.
	This list is not intended to be exhaustive but just to catch the
	cases that occur easily if some attempts to product protect
	the package containing the protected session manager."

	^ (aClass respondsTo: #isSafeToEncryptWithProductProtection)
		ifTrue: [aClass isSafeToEncryptWithProductProtection]
		ifFalse: ["presumably its OK" ^ true].!

load
	"Loads the required packages into the image for the receiver. Does not remove any
	packages that should not be present"

	self basicLoad.
	SessionManager current saveImage
!

loadAndShrink
	"Loads the required packages into the image for the receiver. Also shrinks the image
	to remove packages that should not be present but does not compress the sources or save the image."

	self
		basicLoad;
		removeUnlistedPackages!

loadShrinkAndCompress
	"Loads the required packages into the image for the receiver. Also shrinks the image
	to remove packages that should not be present. Finishes up with a compress sources."

	self
		basicLoad;
		shrink.
	SourceManager default compressSources!

lock
	"Lock the receiver with the serial number determined by our serial number class."

	"the serial number class holds policy decisions about how locking is done, so
	we ask it to arrange the process"

	self serialNumberClass lockClasses: self encryptedClasses.
!

majorVersion
	"Answer the receiver's major version <Integer>"

	^versionMask >> 4!

minorVersion
	"Answer the receiver's minor version <Integer>"

	^versionMask bitAnd: 16r0F!

name
	"Answer the product name associated with the receiver"

	^self class productName!

packageNames
	"Answer the list of package names associated with the receiver"

	^self packagePaths collect: [:each | File splitStemFrom: each ]!

packagePaths
	"Answer the list of package path names associated with the receiver"

	^self contents collect: [:each | each at: 1 ]!

packages
	"Answer the list of package associated with the receiver"

	^(self packageNames collect: [:each | Package manager packageNamed: each ])
!

preShrink
	"Private - Perform any pre-shrinkage actions"!

printOn: aStream
	"Append a textual representation of the receiver to the <puttableStream> argument
	as a developer might want to see it."

	aStream 
		basicPrint: self;
		nextPut: $(;
		print: self name;
		nextPut: $,;
		print: self version;
		nextPut: $)!

productDetails
	"Answers the product details for the receiver"

	| array |
	array := VMLibrary default defaultProductDetails.
	8 < array size ifTrue: [array := (array , (Array new: 8)) copyFrom: 1 to: 8].
	^array
		at: 1 put: self fullName;
		at: 2 put: self name;
		at: 3 put: self version;
		at: 6 put: self shortProductName;
		at: 7 put: nil;
		at: 8 put: nil;
		yourself!

productLevel
	"Answer the <Integer> productLevel for the receiver"

	^self class productLevel!

removeUnlistedPackages
	"Private - Removes the non-required packages from the image for the receiver. "

	| unwanted |
	unwanted := Package manager packages difference: self packages.
	unwanted do: [:each | self uninstallPackage: each]!

resizeSymbolTable
	Symbol resizeTable	"Resize the symbol table to suit the size of the development product."!

shortProductName
	"Answer the abbreviated product name"
	
	^self class shortProductName!

shouldEncryptMetaclasses
	"Answer whether we should encrypt the class-side methods of our protected classes."

	^false!

shrink
	"Removes the non-required packages from the image for the receiver. "

	self preShrink.
	self warnOfUnlistedContent.
	self removeUnlistedPackages.
	self shrinkEventsRegister.
	self shrinkHashedCollections.
	self foldLiterals.
	"Resize the symbol table to suit the size of the development product."
	self resizeSymbolTable!

shrinkEventsRegister
	Object _eventsRegister keys do: [:each | each setEvents: each getEvents shrink]!

shrinkHashedCollections
	Set primAllSubinstances do: [:each | each shrink]!

uninstallPackage: each 
	^each uninstall!

unlistedContentException
	^Error!

unlistedPrerequisites
	| all listed |
	all := self allPackages.
	listed := self packages.
	^all difference: listed!

unlockUsing: aSerialNumber 
	"Unlock the receiver with aSerialNumber
	The serial number class holds policy decisions about how locking is done, so
	we ask it to arrange the process"

	self serialNumberClass unlockClasses: self encryptedClasses using: aSerialNumber!

unwantedClasses
	"Answer a collection of the names of classes that are (or might) be in the distributed packages, but which we don't
	want included in the actual distributions."

	^#(#BootSessionManager #DolphinOAEdition)!

version
	"Answer the receiver's version <Float>"

	^(self majorVersion + (self minorVersion / 10)) asFloat!

versionMask
	"Private - Answer the receiver's version mask"

	^versionMask!

versionMask: anInteger
	"Private - Initialise the receiver from anInteger version mask"

	versionMask := anInteger!

warnOfUnlistedContent
! !
!DolphinProduct categoriesFor: #allPackages!accessing!public! !
!DolphinProduct categoriesFor: #basicLoad!operations!private! !
!DolphinProduct categoriesFor: #beCurrent!operations!public! !
!DolphinProduct categoriesFor: #boot!operations!private! !
!DolphinProduct categoriesFor: #contents!accessing!public! !
!DolphinProduct categoriesFor: #deepPrerequisitesOf:!helpers!private! !
!DolphinProduct categoriesFor: #diskBasedPackages!accessing!private! !
!DolphinProduct categoriesFor: #displayOn:!printing!public! !
!DolphinProduct categoriesFor: #encryptedClasses!accessing!public! !
!DolphinProduct categoriesFor: #encryptedClasses:!accessing!private! !
!DolphinProduct categoriesFor: #encryptedPackageNames!accessing!public! !
!DolphinProduct categoriesFor: #foldLiterals!private! !
!DolphinProduct categoriesFor: #fullName!accessing!public! !
!DolphinProduct categoriesFor: #imageLevel!constants!public! !
!DolphinProduct categoriesFor: #installProductDetails!operations!private! !
!DolphinProduct categoriesFor: #installProductSounds!operations!private! !
!DolphinProduct categoriesFor: #installSplash!private! !
!DolphinProduct categoriesFor: #isSafeToEncrypt:!helpers!private! !
!DolphinProduct categoriesFor: #load!operations!public! !
!DolphinProduct categoriesFor: #loadAndShrink!operations!public! !
!DolphinProduct categoriesFor: #loadShrinkAndCompress!operations!public! !
!DolphinProduct categoriesFor: #lock!operations!public! !
!DolphinProduct categoriesFor: #majorVersion!accessing!public! !
!DolphinProduct categoriesFor: #minorVersion!accessing!public! !
!DolphinProduct categoriesFor: #name!accessing!public! !
!DolphinProduct categoriesFor: #packageNames!accessing!public! !
!DolphinProduct categoriesFor: #packagePaths!accessing!public! !
!DolphinProduct categoriesFor: #packages!accessing!public! !
!DolphinProduct categoriesFor: #preShrink!private! !
!DolphinProduct categoriesFor: #printOn:!printing!public! !
!DolphinProduct categoriesFor: #productDetails!accessing!public! !
!DolphinProduct categoriesFor: #productLevel!constants!public! !
!DolphinProduct categoriesFor: #removeUnlistedPackages!operations!private! !
!DolphinProduct categoriesFor: #resizeSymbolTable!operations!public! !
!DolphinProduct categoriesFor: #shortProductName!accessing!public! !
!DolphinProduct categoriesFor: #shouldEncryptMetaclasses!constants!public!testing! !
!DolphinProduct categoriesFor: #shrink!operations!public! !
!DolphinProduct categoriesFor: #shrinkEventsRegister!operations!private! !
!DolphinProduct categoriesFor: #shrinkHashedCollections!operations!private! !
!DolphinProduct categoriesFor: #uninstallPackage:!operations!private! !
!DolphinProduct categoriesFor: #unlistedContentException!operations!public! !
!DolphinProduct categoriesFor: #unlistedPrerequisites!public! !
!DolphinProduct categoriesFor: #unlockUsing:!operations!public! !
!DolphinProduct categoriesFor: #unwantedClasses!constants!public! !
!DolphinProduct categoriesFor: #version!accessing!public! !
!DolphinProduct categoriesFor: #versionMask!accessing!private! !
!DolphinProduct categoriesFor: #versionMask:!accessing!initializing!private! !
!DolphinProduct categoriesFor: #warnOfUnlistedContent!operations!private! !

!DolphinProduct class methodsFor!

boot
	"Loads an instance of the receiver"

	self new boot!

current
	"Answer the singleton instance which represents the current product level of this image"

	^Current!

errorInvalidProductDescription: aString
	^self error: 'Invalid product description: ', aString!

fromString: aString
	"Answer an instance of the subclass from the <readableString> description, aString"

	| stm version sub |
	(aString beginsWith: self productPrefix) ifFalse: [self errorInvalidProductDescription: aString].
	stm := aString readStream.
	stm position: self productPrefix size+1.
	version := Float readFrom: stm.
	version = 0.0 ifTrue: [self errorInvalidProductDescription: aString].
	stm skipSeparators.
	sub := stm upToEnd.
	^(EditionsMap at: sub) version: version!

icon
	"Answers an Icon that can be used to represent this class"

	^Smalltalk developmentSystem icon!

initialize
	"Private - Initialize the receiver's class variables.
		self initialize
	"

	EditionsMap := LookupTable new.
	DolphinBaseProduct allSubclasses do: [:p | EditionsMap at: p productName put: p].
	EditionsMap shrink!

isAbstract
	^true!

loadAndShrink
	"Makes the image an instance of the receiver"

	self new loadAndShrink!

new
	"Answers an instance of the receiver for this version of Dolphin"

	^self version: SessionManager current productVersion
!

ofImageLevel: imageLevel
	| versionMask productMask |
	productMask := imageLevel bitAnd: 255.
	versionMask := imageLevel >> 8.
	^(self allSubclasses detect: [:each | each productMask = productMask]) 
		versionMask: versionMask!

ofSerialNumber: serialNo
	"Private - Answers an instance of the receiver that pertains to <DolphinSerialNumber> serialNo."

	^self ofImageLevel: serialNo imageLevel!

packages: wildcard under: directory encrypted: aBoolean 
	| base answer |
	answer := OrderedCollection new.
	base := SessionManager current imageBase.
	File 
		forAll: wildcard
		in: (File composePath: base subPath: directory)
		do: 
			[:each | 
			answer add: (Array 
						with: (File relativePathOf: each path to: base)
						with: (aBoolean ifTrue: [#encrypted] ifFalse: [#plain])
						with: #imageBased)].
	^answer!

pacsUnder: directory encrypted: aBoolean 
	"Note that the order won't be right, but this doesn't really matter since the package loaders prerequisites
	mechanism will load things in the right order anyway."

	^self 
		packages: '*.pac'
		under: directory
		encrypted: aBoolean!

paxesUnder: directory encrypted: aBoolean 
	"Note that the order won't be right, but this doesn't really matter since the package loaders prerequisites
	mechanism will load things in the right order anyway."

	^self 
		packages: '*.pax'
		under: directory
		encrypted: aBoolean!

productLevel
	"Private - Answer the product ID for the receiver"

	self subclassResponsibility!

productMask
	"Private - Answer the <byte> mask product for the receiver"

	^self productLevel << 4!

productName
	"Answer the product name"
	
	^self subclassResponsibility!

productPrefix
	"Answer the prefix common to all product names."

	^'Dolphin Smalltalk'!

release
	"Release an instance of the receiver"

	self new release!

shortProductName
	"Answer the abbreviated product name"
	
	^self subclassResponsibility!

version: version
	"Answers an instance of the receiver  with <Float> version"

	| versionMask |
	versionMask := (version floor << 4) |  (version fractionPart * 10) asInteger.
	^self versionMask: versionMask
!

versionMask: versionMask 
	"Private - Answers an instance of the receiver with <Integer> versionMask"

	^(super new)
		versionMask: versionMask;
		yourself! !
!DolphinProduct class categoriesFor: #boot!operations!public! !
!DolphinProduct class categoriesFor: #current!accessing!public! !
!DolphinProduct class categoriesFor: #errorInvalidProductDescription:!exceptions!public! !
!DolphinProduct class categoriesFor: #fromString:!instance creation!public! !
!DolphinProduct class categoriesFor: #icon!constants!public! !
!DolphinProduct class categoriesFor: #initialize!initializing!private! !
!DolphinProduct class categoriesFor: #isAbstract!operations!public!testing! !
!DolphinProduct class categoriesFor: #loadAndShrink!operations!public! !
!DolphinProduct class categoriesFor: #new!instance creation!public! !
!DolphinProduct class categoriesFor: #ofImageLevel:!instance creation!private! !
!DolphinProduct class categoriesFor: #ofSerialNumber:!instance creation!private! !
!DolphinProduct class categoriesFor: #packages:under:encrypted:!private! !
!DolphinProduct class categoriesFor: #pacsUnder:encrypted:!private! !
!DolphinProduct class categoriesFor: #paxesUnder:encrypted:!private! !
!DolphinProduct class categoriesFor: #productLevel!constants!private! !
!DolphinProduct class categoriesFor: #productMask!accessing!private! !
!DolphinProduct class categoriesFor: #productName!accessing!public! !
!DolphinProduct class categoriesFor: #productPrefix!instance creation!public! !
!DolphinProduct class categoriesFor: #release!operations!public! !
!DolphinProduct class categoriesFor: #shortProductName!accessing!public! !
!DolphinProduct class categoriesFor: #version:!instance creation!public! !
!DolphinProduct class categoriesFor: #versionMask:!instance creation!private! !

