"Filed out from Dolphin Smalltalk X6"!

IUnknown subclass: #ISAXDeclHandler
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'MSXMLConstants'
	classInstanceVariableNames: ''!
ISAXDeclHandler guid: (IID fromString: '{862629AC-771A-47B2-8337-4E6843C1BE90}')!
ISAXDeclHandler comment: '<ISAXDeclHandler> is a wrapper class for the COM interface ''MSXML2.ISAXDeclHandler'' generated from type information in the ''Microsoft XML, v4.0'' library. It contains methods to invoke the member functions exposed by that interface.

The type library contains the following helpstring for this interface
	"ISAXDeclHandler interface"

Warning: This comment was automatically generated from the interface''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

[
	object, 
	uuid(862629AC-771A-47B2-8337-4E6843C1BE90), 
	helpstring("ISAXDeclHandler interface"), 
	hidden
]
interface ISAXDeclHandler : IUnknown
 {
	[id(0x60010000)]
	HRESULT __stdcall elementDecl(
		[in]unsigned short* pwchName,
		[in]int cchName,
		[in]unsigned short* pwchModel,
		[in]int cchModel);
	[id(0x60010001)]
	HRESULT __stdcall attributeDecl(
		[in]unsigned short* pwchElementName,
		[in]int cchElementName,
		[in]unsigned short* pwchAttributeName,
		[in]int cchAttributeName,
		[in]unsigned short* pwchType,
		[in]int cchType,
		[in]unsigned short* pwchValueDefault,
		[in]int cchValueDefault,
		[in]unsigned short* pwchValue,
		[in]int cchValue);
	[id(0x60010002)]
	HRESULT __stdcall internalEntityDecl(
		[in]unsigned short* pwchName,
		[in]int cchName,
		[in]unsigned short* pwchValue,
		[in]int cchValue);
	[id(0x60010003)]
	HRESULT __stdcall externalEntityDecl(
		[in]unsigned short* pwchName,
		[in]int cchName,
		[in]unsigned short* pwchPublicId,
		[in]int cchPublicId,
		[in]unsigned short* pwchSystemId,
		[in]int cchSystemId);
};
'!
!ISAXDeclHandler categoriesForClass!COM-Interfaces!MSXML2-Interfaces! !
!ISAXDeclHandler methodsFor!

AttributeDecl: pwchElementName cchElementName: cchElementName pwchAttributeName: pwchAttributeName cchAttributeName: cchAttributeName pwchType: pwchType cchType: cchType pwchValueDefault: pwchValueDefault cchValueDefault: cchValueDefault pwchValue: pwchValue cchValue: cchValue
	"Invoke the attributeDecl() method of the COM object.

		HRESULT __stdcall attributeDecl(
			[in]unsigned short* pwchElementName,
			[in]int cchElementName,
			[in]unsigned short* pwchAttributeName,
			[in]int cchAttributeName,
			[in]unsigned short* pwchType,
			[in]int cchType,
			[in]unsigned short* pwchValueDefault,
			[in]int cchValueDefault,
			[in]unsigned short* pwchValue,
			[in]int cchValue);"

	<virtual stdcall: hresult 5 word* sdword word* sdword word* sdword word* sdword word* sdword>
	^self invalidCall!

ElementDecl: pwchName cchName: cchName pwchModel: pwchModel cchModel: cchModel
	"Invoke the elementDecl() method of the COM object.

		HRESULT __stdcall elementDecl(
			[in]unsigned short* pwchName,
			[in]int cchName,
			[in]unsigned short* pwchModel,
			[in]int cchModel);"

	<virtual stdcall: hresult 4 word* sdword word* sdword>
	^self invalidCall!

ExternalEntityDecl: pwchName cchName: cchName pwchPublicId: pwchPublicId cchPublicId: cchPublicId pwchSystemId: pwchSystemId cchSystemId: cchSystemId
	"Invoke the externalEntityDecl() method of the COM object.

		HRESULT __stdcall externalEntityDecl(
			[in]unsigned short* pwchName,
			[in]int cchName,
			[in]unsigned short* pwchPublicId,
			[in]int cchPublicId,
			[in]unsigned short* pwchSystemId,
			[in]int cchSystemId);"

	<virtual stdcall: hresult 7 word* sdword word* sdword word* sdword>
	^self invalidCall!

InternalEntityDecl: pwchName cchName: cchName pwchValue: pwchValue cchValue: cchValue
	"Invoke the internalEntityDecl() method of the COM object.

		HRESULT __stdcall internalEntityDecl(
			[in]unsigned short* pwchName,
			[in]int cchName,
			[in]unsigned short* pwchValue,
			[in]int cchValue);"

	<virtual stdcall: hresult 6 word* sdword word* sdword>
	^self invalidCall! !
!ISAXDeclHandler categoriesFor: #AttributeDecl:cchElementName:pwchAttributeName:cchAttributeName:pwchType:cchType:pwchValueDefault:cchValueDefault:pwchValue:cchValue:!**auto generated**!COM Interfaces-ISAXDeclHandler!public! !
!ISAXDeclHandler categoriesFor: #ElementDecl:cchName:pwchModel:cchModel:!**auto generated**!COM Interfaces-ISAXDeclHandler!public! !
!ISAXDeclHandler categoriesFor: #ExternalEntityDecl:cchName:pwchPublicId:cchPublicId:pwchSystemId:cchSystemId:!**auto generated**!COM Interfaces-ISAXDeclHandler!public! !
!ISAXDeclHandler categoriesFor: #InternalEntityDecl:cchName:pwchValue:cchValue:!**auto generated**!COM Interfaces-ISAXDeclHandler!public! !

!ISAXDeclHandler class methodsFor!

defineFunctions
	"Declare the virtual function table for the COM interface 'MSXML2.ISAXDeclHandler'
		ISAXDeclHandler defineTemplate"

	self
		defineFunction: #ElementDecl:cchName:pwchModel:cchModel:
			argumentTypes: 'word* sdword word* sdword';
		defineFunction: #AttributeDecl:cchElementName:pwchAttributeName:cchAttributeName:pwchType:cchType:pwchValueDefault:cchValueDefault:pwchValue:cchValue:
			argumentTypes: 'word* sdword word* sdword word* sdword word* sdword word* sdword';
		defineFunction: #InternalEntityDecl:cchName:pwchValue:cchValue:
			argumentTypes: 'word* sdword word* sdword';
		defineFunction: #ExternalEntityDecl:cchName:pwchPublicId:cchPublicId:pwchSystemId:cchSystemId:
			argumentTypes: 'word* sdword word* sdword word* sdword'
! !
!ISAXDeclHandler class categoriesFor: #defineFunctions!**auto generated**!initializing!public! !

