!classDefinition: #TusLibrosTest category: #'TusLibros-Ejercicio'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 21:36:37'!
test01createCartConIdentificacionValidaDevuelveUnaIDdeCarrito
	
	| server userDict cartID |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123' .
	server _ ServerSimulator withUsers: userDict.
	
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123'.
	self assert: ( cartID = 1 ) .
	self assert: ( server cartIDExists: 1 ).! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 21:49:30'!
test02createCartConIdentificacionInvalidaDevuelveDescripcionDeError

	| server |
	server _ ServerSimulator withUsers: Dictionary new.

	self should: [ server createCartWithUser: 'pepe' andPass: 'pipo123'. ]
		  raise: Error
		  withExceptionDo: [ :anError | self assert: anError messageText = 'Invalid user or password'].
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:12:39'!
test03addToCartConDatosValidosAgregaCorrectamenteElLibroACarritoVacio

	| server userDict cartID bookDict |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123' .
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ (ServerSimulator withUsers: userDict) withBooks: bookDict.
	
	
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123'.
	server addBook: 123 withQuantity: 3 toCart: cartID.
	
	self assert: ( server inCart: cartID book: 123 isTimes: 3 ).! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 20:09:53'!
test04addToCartConCarritoInvalidoDevuelveDescripcionDeError! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:13:02'!
test04addToCartConDatosValidosAgregaCorrectamenteUnLibroYaIncluido

	| server userDict cartID bookDict |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123' .
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ (ServerSimulator withUsers: userDict) withBooks: bookDict.
	
	
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123'.
	server addBook: 123 withQuantity: 3 toCart: cartID.
	server addBook: 123 withQuantity: 2 toCart: cartID.
	
	self assert: ( server inCart: cartID book: 123 isTimes: 5 ).! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 20:10:18'!
test05addToCartConLibroInvalidoDevuelveDescripcionDeError! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 20:05:07'!
testXXlistCartDeCarritoConMultiplesElementosDevuelve0yLibrosConCantidades! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 20:05:17'!
testXXlistCartDeCarritoConUnElementoDevuelve0yLibroConCantidad1! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 20:05:00'!
testXXlistCartDeCarritoInvalidoDevuelveDescripcionDeError! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 20:05:56'!
testXXlistCartDeCarritoVacioDevuelve0! !


!classDefinition: #Cart category: #'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:17:27'!
addBook: aBook times: aQuantity
	
	( books includesKey: aBook ) 
		ifTrue: [ books at: aBook put: (books at: aBook + aQuantity) ]
		ifFalse: [ books at: aBook put: aQuantity ]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:10:21'!
hasBook: aBook times: aQuantity
	
	^ ( books at: aBook ) = aQuantity.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:08:17'!
initialize

	books _ Dictionary new.! !


!classDefinition: #ServerSimulator category: #'TusLibros-Ejercicio'!
Object subclass: #ServerSimulator
	instanceVariableNames: 'users editorial lastCart carts books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 20:58:44'!
WithUsers: aUserDictionary 
	users _ aUserDictionary! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:12:22'!
addBook: aBook withQuantity: aQuantity toCart: aCartID
	(carts at: aCartID)
		addBook: aBook
		times: aQuantity.! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 21:37:47'!
cartIDExists: aCartID
	^ carts includesKey: aCartID.
	! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 21:28:00'!
createCartWith: aCartID
	
	carts at: aCartID put: Cart new.! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 21:25:47'!
createCartWithUser: aUser andPass: aPassword

	self validateUser: aUser andPass: aPassword.
	self createCartWith: (lastCart+1).
	lastCart _ lastCart + 1.
	^ lastCart.! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:09:34'!
inCart: aCart book: aBook isTimes: aQuantity 
	
	^ ( carts at: aCart ) hasBook: aBook times: aQuantity .! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 21:41:31'!
initialize
	
	lastCart _ 0.
	carts _ Dictionary new.
	users _ Dictionary new.! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 20:43:20'!
initializeWithUsers: aUserDictionary 
	users _ aUserDictionary .
	! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 21:48:39'!
validateUser: aUser andPass: aPassword 
	
	( users includesKey: aUser ) 
		ifFalse: [ self error: self class InvalidUserOrPasswordDescription].
	( (users at: aUser) = aPassword ) 
		ifFalse: [ self error: self class InvalidUserOrPasswordDescription].! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:04:41'!
withBooks: aBookDict
	
	books _ aBookDict! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ServerSimulator class' category: #'TusLibros-Ejercicio'!
ServerSimulator class
	instanceVariableNames: ''!

!ServerSimulator class methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 21:48:59'!
InvalidUserOrPasswordDescription
	
	^ 'Invalid user or password'! !

!ServerSimulator class methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 20:58:12'!
withUsers: aUserDictionary 

	^ (self new initialize) WithUsers: aUserDictionary.! !
