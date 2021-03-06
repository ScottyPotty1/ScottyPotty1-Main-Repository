"Filed out from Dolphin Smalltalk X6.1"!

Boolean subclass: #False
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
False guid: (GUID fromString: '{87B4C4FD-026E-11D3-9FD7-00A0CC3E4A32}')!
False comment: 'The False class implements the behaviour of the false (logical false) object.

False is a singleton whose sole instance is the object represented by the reserved word, false. (i.e. any reference to false will always answer true when compared with any other using the #== message).

False implement the ANSI protocols <Object> and <boolean>.'!
!False categoriesForClass!Kernel-Objects! !
!False methodsFor!

and: operand 
	"Answer whether the receiver and the result of evaluating the <niladicValuable>,
	 operand, are both true. The argument is only evaluated if the receiver is true."

	"Implementation Note:  The compiler inlines this message if the argument
	is a literal block. The compiler assumes that the receiver will be a boolean,
	so this message cannot be overridden."

	^self!

asDword
	"Answer the receiver in a form suitable for passing/returning as a
	32-bit integer value."

	^0!

asParameter
	"Answer the value of the receiver in a form suitable for
	passing to an external function call."

	^0
!

asUIntPtr
	"Answer the receiver in a form suitable for passing/returning as a Windows LRESULT
	(32 or 64-bit, depending on host OS) return value. The default is self (which will cause the
	default window proc. of the window to be called for most objects other than Integers when
	used as a return value)."

	^0!

ifFalse: operand 
	"Evaluate and answer the result of the evaluating the <niladicValuable>
	argument, operand, if the receiver is false, otherwise answer nil. "

	"Implementation Note:  The compiler inlines this message if the argument
	is a literal block. The compiler assumes that the receiver will be a boolean,
	so this message cannot be overridden."

	^operand value!

ifFalse: falseOperand ifTrue: trueOperand 
	"Evaluate, and answer the result, of the <niladicValuable>, falseOperand, if 
	the receiver is false, or the <niladicValuable>, trueOperand, if the receiver is 
	true."

	"Implementation Note:  The compiler inlines this message if the arguments
	are literal blocks. The compiler assumes that the receiver will be a boolean,
	so this message cannot be overridden."

	^falseOperand value!

ifTrue: operand 
	"Evaluate and answer the result of the evaluating the <niladicValuable>
	argument, operand, if the receiver is true, otherwise answer nil."

	"Implementation Note:  The compiler inlines this message if the argument
	is a literal block. The compiler assumes that the receiver will be a boolean,
	so this message cannot be overridden."

	^nil!

ifTrue: trueOperand ifFalse: falseOperand 
	"Evaluate, and answer the result, of the <niladicValuable>, falseOperand, if 
	the receiver is false, or the <niladicValuable>, trueOperand, if the receiver is 
	true."

	"Implementation Note:  The compiler inlines this message if the arguments
	are literal blocks. The compiler assumes that the receiver will be a boolean,
	so this message cannot be overridden."

	^falseOperand value!

not
	"Answer the logical inverse of the receiver."

	^true
!

or: operand 
	"Answer whether either the receiver or the result of evaluating the
	<niladicValuable> argument, operand, is true. The argument is only
	evaluated if the receiver is false."

	"Implementation Note:  The compiler inlines this message if the argument
	is a literal block. The compiler assumes that the receiver will be a boolean,
	so this message cannot be overridden."

	^operand value!

printOn: target
	"Append the a textual representation of the receiver to the puttableStream, <target>..
	Note that this override refines #printString to comply with the ANSI 
	protocol <boolean>."
	
	target nextPutAll: 'false'!

xor: operand
	"Answer whether either the receiver or the boolean argument <operand>
	is true, but not both.
	Since the receiver is false, the answer depends entirely on the argument."

	^operand! !
!False categoriesFor: #and:!control flow!public! !
!False categoriesFor: #asDword!converting!public! !
!False categoriesFor: #asParameter!converting!public! !
!False categoriesFor: #asUIntPtr!converting!public! !
!False categoriesFor: #ifFalse:!control flow!public! !
!False categoriesFor: #ifFalse:ifTrue:!control flow!public! !
!False categoriesFor: #ifTrue:!control flow!public! !
!False categoriesFor: #ifTrue:ifFalse:!control flow!public! !
!False categoriesFor: #not!logical operations!public! !
!False categoriesFor: #or:!control flow!public! !
!False categoriesFor: #printOn:!printing!public! !
!False categoriesFor: #xor:!logical operations!public! !

!False class methodsFor!

icon
	"Answers an Icon that can be used to represent this class"

	^##(self) defaultIcon! !
!False class categoriesFor: #icon!constants!public! !

