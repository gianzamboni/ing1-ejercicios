!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #IdiomTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #IdiomTest
	instanceVariableNames: 'methodDuration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!IdiomTest methodsFor: 'testing' stamp: 'GF 9/6/2017 17:24:08'!
assert: aClosure shouldNotTakeMoreTimeThan: someTime

	| millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := (Time millisecondClockValue)*millisecond.
	aClosure value.
	millisecondsAfterRunning := (Time millisecondClockValue)*millisecond.
	
	self assert: ((millisecondsAfterRunning  - millisecondsBeforeRunning ) < someTime).! !

!IdiomTest methodsFor: 'testing' stamp: 'gz 9/7/2017 01:26:22'!
assert: aBlockClosure shouldRaise: someError andMustSatisfy: someConditions 

	[ aBlockClosure value.
		self fail ]
		on: someError
		do: someConditions.! !

!IdiomTest methodsFor: 'testing' stamp: 'GF 9/6/2017 17:24:16'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook _ CustomerBook  new.
	self assert: [ customerBook addCustomerNamed: 'John Lennon'. ] shouldNotTakeMoreTimeThan: (50*millisecond).! !

!IdiomTest methodsFor: 'testing' stamp: 'GF 9/6/2017 17:24:24'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	self assert: [ customerBook removeCustomerNamed: paulMcCartney. ] shouldNotTakeMoreTimeThan: 100*millisecond.
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'gz 9/7/2017 01:18:38'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self assert: [ customerBook addCustomerNamed: ''] shouldRaise:  Error andMustSatisfy: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!IdiomTest methodsFor: 'testing' stamp: 'gz 9/7/2017 01:23:36'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assert: [ customerBook removeCustomerNamed: 'Paul McCartney'.] shouldRaise: NotFound andMustSatisfy: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!IdiomTest methodsFor: 'testing' stamp: 'GF 9/6/2017 17:15:34'!
timeClosure: aClosureToTime

	| millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue.	
	aClosureToTime value.
	millisecondsAfterRunning := Time millisecondClockValue.
	^ ((millisecondsAfterRunning  - millisecondsBeforeRunning ) * millisecond).! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
