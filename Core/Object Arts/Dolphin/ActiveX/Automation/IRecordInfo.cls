"Filed out from Dolphin Smalltalk X6"!

IUnknown subclass: #IRecordInfo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'AXAutomationConstants AXAutomationErrors'
	classInstanceVariableNames: ''!
IRecordInfo guid: (IID fromString: '{0000002F-0000-0000-C000-000000000046}')!
IRecordInfo comment: '<IRecordInfo> is a wrapper class for the COM interface ''OLEIDL.IRecordInfo'' generated from type information in the ''OLEIDL Library'' library. It contains methods to invoke the member functions exposed by that interface.

The type library contains no documentation for this interface

Warning: This comment was automatically generated from the interface''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.'!
!IRecordInfo categoriesForClass!COM-Interfaces!OLEIDL-Interfaces! !
!IRecordInfo methodsFor!

byteSize
	"Answer the <integer> size in bytes of the structure described by the receiver."

	| answer |
	answer := DWORD new.
	self GetSize: answer.
	^answer asObject!

getField: fieldNameString from: data ifAbsent: exceptionHandler
	"Answer the value of the named field of the instance of 
	structure described by the receiver, data, or if there is no 
	such field then the result of evaluating the <niladicValuable>, 
	exceptionHandler."

	| hr val |
	val := VARIANT new.
	hr := self
		GetField: data
		szFieldName: fieldNameString asUnicodeString
		pvarField: val.
	^hr < 0
		ifTrue: [
			hr = TYPE_E_FIELDNOTFOUND
				ifTrue: [exceptionHandler value]
				ifFalse: [self hresultError: hr]]
		ifFalse: [val value]	
	

!

GetField: pvData szFieldName: szFieldName pvarField: pvarField
	"Private - Invoke the GetField() method of the COM object wrapped by the receiver.

		HRESULT __stdcall GetField(
			[in] void* pvData,
			[in] LPWSTR szFieldName,
			[out] VARIANT* pvarField);

	Implementation Note: Return an integer code rather than raising an exception as attempting
	to look up a field which is not present is a common occurrence. Callers must check the return
	code for errors.
	"

	<virtual stdcall: sdword 11 void* lpwstr variant*>
	^self invalidCall
!

getFieldNames
	"Answer a <collection> of the names of the receiver's fields."

	| cNames size bstr pNames |
	cNames := DWORD new.
	self GetFieldNames: cNames rgBstrNames: nil.
	size := cNames asInteger.
	pNames := DWORDArray new: size.
	self GetFieldNames: cNames rgBstrNames: pNames yourAddress.
	bstr := BSTR new.
	^pNames collect: 
			[:e | 
			| name |
			bstr attach: e.
			name := bstr asString.
			bstr basicFree.
			name]!

GetFieldNames: pcNames rgBstrNames: rgBstrNames
	"Private - Invoke the GetFieldNames() method of the COM object wrapped by the receiver.

		HRESULT __stdcall GetFieldNames(
			[in, out] unsigned long* pcNames,
			[out] BSTR* rgBstrNames);
	"

	<virtual stdcall: hresult 15 dword* bstr*>
	^self invalidCall
!

GetFieldNoCopy: pvData szFieldName: szFieldName pvarField: pvarField ppvDataCArray: ppvDataCArray
	"Private - Invoke the GetFieldNoCopy() method of the COM object wrapped by the receiver.

		HRESULT __stdcall GetFieldNoCopy(
			[in] void* pvData,
			[in] LPWSTR szFieldName,
			[out] VARIANT* pvarField,
			[out] void** ppvDataCArray);
	"

	<virtual stdcall: hresult 12 void* lpwstr variant* void**>
	^self invalidCall
!

GetGuid: pguid
	"Private - Invoke the GetGuid() method of the COM object wrapped by the receiver.

		HRESULT __stdcall GetGuid(
			[out] GUID* pguid);
	"

	<virtual stdcall: hresult 7 GUID*>
	^self invalidCall
!

GetName: pbstrName
	"Private - Invoke the GetName() method of the COM object wrapped by the receiver.

		HRESULT __stdcall GetName(
			[out] BSTR* pbstrName);
	"

	<virtual stdcall: hresult 8 bstr*>
	^self invalidCall
!

GetSize: pcbSize
	"Private - Invoke the GetSize() method of the COM object wrapped by the receiver.

		HRESULT __stdcall GetSize(
			[out] unsigned long* pcbSize);
	"

	<virtual stdcall: hresult 9 dword*>
	^self invalidCall
!

GetTypeInfo: ppTypeInfo
	"Private - Invoke the GetTypeInfo() method of the COM object wrapped by the receiver.

		HRESULT __stdcall GetTypeInfo(
			[out] ITypeInfo** ppTypeInfo);
	"

	<virtual stdcall: hresult 10 ITypeInfo**>
	^self invalidCall
!

guid
	"Answer the <GUID> of the structure the receiver describes."

	| answer |
	answer := GUID new.
	self GetGuid: answer.
	^answer!

IsMatchingType: pRecordInfo
	"Invoke the IsMatchingType() method of the COM object wrapped by the receiver.

		long __stdcall IsMatchingType(
			[in] IRecordInfo* pRecordInfo);
	"

	<virtual stdcall: sdword 16 IRecordInfo*>
	^self invalidCall
!

name
	"Answer the name of the structure described by the receiver."

	| answer  bstr |
	bstr := BSTR new.
	self GetName: bstr.
	answer := bstr asString.
	bstr free.
	^answer!

PutField: wFlags pvData: pvData szFieldName: szFieldName pvarField: pvarField
	"Private - Invoke the PutField() method of the COM object wrapped by the receiver.

		HRESULT __stdcall PutField(
			[in] unsigned long wFlags,
			[in, out] void* pvData,
			[in] LPWSTR szFieldName,
			[in] VARIANT* pvarField);

	Implementation Note: Return an integer code rather than raising an exception as attempting
	to look up a field which is not present is a common occurrence. Callers must check the return
	code for errors."

	<virtual stdcall: sdword 13 dword void* lpwstr variant*>
	^self invalidCall
!

PutFieldNoCopy: wFlags pvData: pvData szFieldName: szFieldName pvarField: pvarField
	"Private - Invoke the PutFieldNoCopy() method of the COM object wrapped by the receiver.

		HRESULT __stdcall PutFieldNoCopy(
			[in] unsigned long wFlags,
			[in, out] void* pvData,
			[in] LPWSTR szFieldName,
			[in] VARIANT* pvarField);
	"

	<virtual stdcall: hresult 14 dword void* lpwstr variant*>
	^self invalidCall
!

RecordClear: pvExisting
	"Invoke the RecordClear() method of the COM object wrapped by the receiver.

		HRESULT __stdcall RecordClear(
			[in] void* pvExisting);
	"

	<virtual stdcall: hresult 5 void*>
	^self invalidCall
!

RecordCopy: pvExisting pvNew: pvNew
	"Private - Invoke the RecordCopy() method of the COM object wrapped by the receiver.

		HRESULT __stdcall RecordCopy(
			[in] void* pvExisting,
			[out] void* pvNew);
	"

	<virtual stdcall: hresult 6 void* void*>
	^self invalidCall
!

RecordCreate 
	"Invoke the RecordCreate() method of the COM object wrapped by the receiver.

		void* __stdcall RecordCreate();
	"

	<virtual stdcall: void* 17>
	^self invalidCall
!

RecordCreateCopy: pvSource ppvDest: ppvDest
	"Private - Invoke the RecordCreateCopy() method of the COM object wrapped by the receiver.

		HRESULT __stdcall RecordCreateCopy(
			[in] void* pvSource,
			[out] void** ppvDest);
	"

	<virtual stdcall: hresult 18 void* void**>
	^self invalidCall
!

RecordDestroy: pvRecord
	"Invoke the RecordDestroy() method of the COM object wrapped by the receiver.

		HRESULT __stdcall RecordDestroy(
			[in] void* pvRecord);
	"

	<virtual stdcall: hresult 19 void*>
	^self invalidCall!

RecordInit: pvNew
	"Private - Invoke the RecordInit() method of the COM object wrapped by the receiver.

		HRESULT __stdcall RecordInit(
			[out] void* pvNew);
	"

	<virtual stdcall: hresult 4 void*>
	^self invalidCall
!

setField: fieldNameString value: newValue into: data ifAbsent: exceptionHandler
	"Private - Set the value of the named field of the receiver, to the
	variant value of the <variantCompatible> object, newValue,
	or if there is no such field then evaluate the <niladicValuable>, 
	exceptionHandler. Answer newValue."

	| hr |
	hr := self
		PutField: INVOKE_PROPERTYPUT
		pvData: data
		szFieldName: fieldNameString asUnicodeString
		pvarField: newValue asVariant.
	^hr < 0 ifTrue: [
		hr = TYPE_E_FIELDNOTFOUND
			ifTrue: [exceptionHandler value]
			ifFalse: [self hresultError: hr]]
		ifFalse: [newValue]!

typeInfo
	"Answer the <ITypeInfo> associated with the receiver."

	| answer |
	answer := ITypeInfo newPointer.
	self
		GetTypeInfo: answer.
	^answer asObject
! !
!IRecordInfo categoriesFor: #byteSize!accessing!public! !
!IRecordInfo categoriesFor: #getField:from:ifAbsent:!accessing!private! !
!IRecordInfo categoriesFor: #GetField:szFieldName:pvarField:!COM Interfaces-IRecordInfo!private! !
!IRecordInfo categoriesFor: #getFieldNames!accessing!public! !
!IRecordInfo categoriesFor: #GetFieldNames:rgBstrNames:!**auto generated**!COM Interfaces-IRecordInfo!private! !
!IRecordInfo categoriesFor: #GetFieldNoCopy:szFieldName:pvarField:ppvDataCArray:!**auto generated**!COM Interfaces-IRecordInfo!private! !
!IRecordInfo categoriesFor: #GetGuid:!**auto generated**!COM Interfaces-IRecordInfo!private! !
!IRecordInfo categoriesFor: #GetName:!**auto generated**!COM Interfaces-IRecordInfo!private! !
!IRecordInfo categoriesFor: #GetSize:!**auto generated**!COM Interfaces-IRecordInfo!private! !
!IRecordInfo categoriesFor: #GetTypeInfo:!**auto generated**!COM Interfaces-IRecordInfo!private! !
!IRecordInfo categoriesFor: #guid!accessing!public! !
!IRecordInfo categoriesFor: #IsMatchingType:!**auto generated**!COM Interfaces-IRecordInfo!public! !
!IRecordInfo categoriesFor: #name!accessing!public! !
!IRecordInfo categoriesFor: #PutField:pvData:szFieldName:pvarField:!COM Interfaces-IRecordInfo!private! !
!IRecordInfo categoriesFor: #PutFieldNoCopy:pvData:szFieldName:pvarField:!**auto generated**!COM Interfaces-IRecordInfo!private! !
!IRecordInfo categoriesFor: #RecordClear:!**auto generated**!COM Interfaces-IRecordInfo!public! !
!IRecordInfo categoriesFor: #RecordCopy:pvNew:!**auto generated**!COM Interfaces-IRecordInfo!private! !
!IRecordInfo categoriesFor: #RecordCreate!**auto generated**!COM Interfaces-IRecordInfo!public! !
!IRecordInfo categoriesFor: #RecordCreateCopy:ppvDest:!**auto generated**!COM Interfaces-IRecordInfo!private! !
!IRecordInfo categoriesFor: #RecordDestroy:!**auto generated**!COM Interfaces-IRecordInfo!public! !
!IRecordInfo categoriesFor: #RecordInit:!**auto generated**!COM Interfaces-IRecordInfo!private! !
!IRecordInfo categoriesFor: #setField:value:into:ifAbsent:!accessing!private! !
!IRecordInfo categoriesFor: #typeInfo!methods!public! !

IRecordInfo methodProtocol: #IRecordInfo attributes: #(#readOnly) selectors: #(#GetField:szFieldName:pvarField: #GetFieldNames:rgBstrNames: #GetFieldNoCopy:szFieldName:pvarField:ppvDataCArray: #GetGuid: #GetName: #GetSize: #GetTypeInfo: #IsMatchingType: #PutField:pvData:szFieldName:pvarField: #PutFieldNoCopy:pvData:szFieldName:pvarField: #RecordClear: #RecordCopy:pvNew: #RecordCreate #RecordCreateCopy:ppvDest: #RecordDestroy: #RecordInit:)!

!IRecordInfo class methodsFor!

defineFunctions
	"Declare the virtual function table for the COM interface 'OLEIDL.IRecordInfo'
		IRecordInfo defineTemplate
	"

	self
		defineFunction: #RecordInit:
			argumentTypes: 'void*';
		defineFunction: #RecordClear:
			argumentTypes: 'void*';
		defineFunction: #RecordCopy:pvNew:
			argumentTypes: 'void* void*';
		defineFunction: #GetGuid:
			argumentTypes: 'GUID*';
		defineFunction: #GetName:
			argumentTypes: 'bstr*';
		defineFunction: #GetSize:
			argumentTypes: 'dword*';
		defineFunction: #GetTypeInfo:
			argumentTypes: 'ITypeInfo**';
		defineFunction: #GetField:szFieldName:pvarField:
			returnType: 'sdword'
			argumentTypes: 'void* lpwstr variant*';
		defineFunction: #GetFieldNoCopy:szFieldName:pvarField:ppvDataCArray:
			argumentTypes: 'void* lpwstr variant* void**';
		defineFunction: #PutField:pvData:szFieldName:pvarField:
			returnType: 'sdword'
			argumentTypes: 'dword void* lpwstr variant*';
		defineFunction: #PutFieldNoCopy:pvData:szFieldName:pvarField:
			argumentTypes: 'dword void* lpwstr variant*';
		defineFunction: #GetFieldNames:rgBstrNames:
			argumentTypes: 'dword* bstr*';
		defineFunction: #IsMatchingType:
			returnType: 'sdword'
			argumentTypes: 'IRecordInfo*';
		defineFunction: #RecordCreate
			returnType: 'void*';
		defineFunction: #RecordCreateCopy:ppvDest:
			argumentTypes: 'void* void**';
		defineFunction: #RecordDestroy:
			argumentTypes: 'void*'
! !
!IRecordInfo class categoriesFor: #defineFunctions!initializing!public! !

