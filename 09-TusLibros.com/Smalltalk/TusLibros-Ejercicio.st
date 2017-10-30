!classDefinition: #TusLibrosTest category: #'TusLibros-Ejercicio'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!TusLibrosTest methodsFor: 'createCart' stamp: 'GF 10/30/2017 16:33:57'!
test01createCartConIdentificacionValidaDevuelveUnaIDdeCarrito
	
	| server userDict cartID |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123' .
	server _ (ServerSimulator new) withUsers: userDict.
	
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123'.
	self assert: ( cartID = 1 ) .
	self assert: ( (server cart: 1) isEmpty).! !

!TusLibrosTest methodsFor: 'createCart' stamp: 'GF 10/30/2017 16:34:17'!
test02createCartConIdentificacionInvalidaDevuelveDescripcionDeError

	| server |
	server _ ServerSimulator new.

	self should: [ server createCartWithUser: 'pepe' andPass: 'pipo123'. ]
		  raise: Error
		  withExceptionDo: [ :anError | self assert: anError messageText = 'Invalid user or password'].
	! !


!TusLibrosTest methodsFor: 'addToCart' stamp: 'GF 10/30/2017 16:34:33'!
test03addToCartConDatosValidosAgregaCorrectamenteElLibroACarritoVacio

	| server userDict cartID bookDict |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123' .
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ ((ServerSimulator new) withUsers: userDict) withBooks: bookDict.
	
	
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123'.
	server addBook: 123 withQuantity: 3 toCart: cartID.
	
	self assert: ( (server cart: cartID) hasBook: 123 times: 3 ).! !

!TusLibrosTest methodsFor: 'addToCart' stamp: 'GF 10/30/2017 16:34:42'!
test04addToCartConDatosValidosAgregaCorrectamenteUnLibroYaIncluido

	| server userDict cartID bookDict |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123' .
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ ((ServerSimulator new) withUsers: userDict) withBooks: bookDict.
	
	
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123'.
	server addBook: 123 withQuantity: 3 toCart: cartID.
	server addBook: 123 withQuantity: 2 toCart: cartID.
	
	self assert: ( (server cart: cartID) hasBook: 123 times: 5 ).! !

!TusLibrosTest methodsFor: 'addToCart' stamp: 'GF 10/30/2017 19:34:52'!
test05addToCartConLibroInvalidoLevanteError

	| server userDict cartID bookDict |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123' .
	bookDict _ OrderedCollection new.
	server _ ((ServerSimulator new) withUsers: userDict) withBooks: bookDict.
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123'.
	
	self should: [ server addBook: 123 withQuantity: 3 toCart: cartID. ]
		  raise: Error
		  withExceptionDo: [ :anError | 
			self assert: anError messageText = 'Invalid book'.
			self assert: (server cart: cartID ) isEmpty.
			].! !

!TusLibrosTest methodsFor: 'addToCart' stamp: 'GF 10/30/2017 19:36:11'!
test06addToCartConDatosValidosPeroCantidadInvalidaLevantaError

	| server userDict cartID bookDict |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123' .
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ ((ServerSimulator new) withUsers: userDict) withBooks: bookDict.
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123'.

	self should: [ server addBook: 123 withQuantity: -2 toCart: cartID. ]
		  raise: Error
		  withExceptionDo: [ :anError | 
			self assert: anError messageText = 'Invalid quantity'.
			self assert: (server cart: cartID ) isEmpty.
			].! !

!TusLibrosTest methodsFor: 'addToCart' stamp: 'GF 10/30/2017 16:22:18'!
test07addToCartConCarritoInvalidoLevantaError

	| server bookDict |
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ (ServerSimulator new) withBooks: bookDict.

	self should: [ server addBook: 123 withQuantity: 1 toCart: 123. ]
		  raise: Error
		  withExceptionDo: [ :anError | self assert: anError messageText = 'Invalid cart'].! !


!TusLibrosTest methodsFor: 'listCart' stamp: 'GF 10/30/2017 16:35:42'!
test08listCartDeCarritoVacioDevuelveUnaColeccionVacia

	| server userDict cartID bookDict |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123' .
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ ((ServerSimulator new) withUsers: userDict) withBooks: bookDict.
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123'.
	
	self assert: ((server listCart: cartID) isEmpty)! !

!TusLibrosTest methodsFor: 'listCart' stamp: 'GF 10/30/2017 16:46:05'!
test09listCartDeCarritoConElementosListaLosLibrosAgregados

	| server userDict cartID bookDict expectedList |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123'.
	bookDict _ OrderedCollection new.
	bookDict add: 1.
	bookDict add: 2.
	server _ ((ServerSimulator new) withUsers: userDict) withBooks: bookDict.
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123'.
	server addBook: 1 withQuantity: 3 toCart: cartID.
	server addBook: 2 withQuantity: 2 toCart: cartID.
	
	expectedList _ Dictionary new.
	expectedList at: 1 put: 3.
	expectedList at: 2 put: 2.
	self assert: ( expectedList = (server listCart: cartID) )
	! !

!TusLibrosTest methodsFor: 'listCart' stamp: 'GF 10/30/2017 16:52:56'!
test10listCartDeCarritoInvalidoLevantaError

	| server |
	server _ ServerSimulator new.
	
	self should: [ server listCart: 1 ]
		  raise: Error
		  withExceptionDo: [ :anError | self assert: anError messageText = 'Invalid cart'].! !


!TusLibrosTest methodsFor: 'checkOutCart' stamp: 'GF 10/30/2017 19:37:23'!
test11checkOutConCarrritoVacioLevantaError

	| server userDict cartID  aCreditCardNumber aCreditCardExpirationDate aCreditCardOwner |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123' .
	server _ ((ServerSimulator new) withUsers: userDict).
	
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123'.
	
	aCreditCardNumber _ 123.
	aCreditCardExpirationDate _ ((DateAndTime now) yearNumber) + 1 + 10000.
	aCreditCardOwner _  'Pepito'.

	self should: [ server checkOutCart: cartID withCreditCardNumber: aCreditCardNumber withExpirationDate: aCreditCardExpirationDate andOwner: aCreditCardOwner ]
		  raise: Error
		  withExceptionDo: [ :anError | self assert: anError messageText = 'Empty Cart' ].! !

!TusLibrosTest methodsFor: 'checkOutCart' stamp: 'GF 10/30/2017 19:27:20'!
test11checkOutConTarjetaVencidaLevantaError


	| server userDict cartID bookDict  aCreditCardNumber aCreditCardExpirationDate aCreditCardOwner |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123' .
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ ((ServerSimulator new) withUsers: userDict) withBooks: bookDict.
	
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123'.
	server addBook: 123 withQuantity: 2 toCart: cartID.
	
	aCreditCardNumber _ 123.
	aCreditCardExpirationDate _ ((DateAndTime now) yearNumber) - 1 + 10000.
	aCreditCardOwner _  'Pepito'.

	self should: [ server checkOutCart: cartID withCreditCardNumber: aCreditCardNumber withExpirationDate: aCreditCardExpirationDate andOwner: aCreditCardOwner ]
		  raise: Error
		  withExceptionDo: [ :anError | self assert: anError messageText = 'Expired credit card'].! !


!classDefinition: #Cart category: #'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:13:48'!
addBook: aBook times: aQuantity
	self validateQuantity: aQuantity.
	( books includesKey: aBook ) 
		ifTrue: [ books at: aBook put: ((books at: aBook) + aQuantity) ]
		ifFalse: [ books at: aBook put: aQuantity ]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:10:21'!
hasBook: aBook times: aQuantity
	
	^ ( books at: aBook ) = aQuantity.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:08:17'!
initialize

	books _ Dictionary new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:05:59'!
isEmpty
	
	^ books isEmpty.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:36:45'!
list
	
	^ books! !

!Cart methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:17:21'!
validateQuantity: aQuantity

	( aQuantity < 1 )
		ifTrue: [ self error: self class invalidQuantityDescription]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:18:30'!
invalidQuantityDescription

	^ 'Invalid quantity'! !


!classDefinition: #ServerSimulator category: #'TusLibros-Ejercicio'!
Object subclass: #ServerSimulator
	instanceVariableNames: 'users editorial lastCart carts books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:24:12'!
addBook: aBook withQuantity: aQuantity toCart: aCartID
	
	self validateCartID: aCartID.
	self validateBook: aBook.
	(carts at: aCartID) addBook: aBook times: aQuantity.! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:32:57'!
cart: aCartID

	self validateCartID: aCartID.
	^ carts at: aCartID ! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 19:19:42'!
checkOutCart: cartID withCreditCardNumber: aCreditCardNumber withExpirationDate: aCreditCardExpirationDate andOwner: aCreditCardOwner

	self validateExpiredCard: aCreditCardExpirationDate.! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 21:28:00'!
createCartWith: aCartID
	
	carts at: aCartID put: Cart new.! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 21:25:47'!
createCartWithUser: aUser andPass: aPassword

	self validateUser: aUser andPass: aPassword.
	self createCartWith: (lastCart+1).
	lastCart _ lastCart + 1.
	^ lastCart.! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:05:20'!
initialize
	
	lastCart _ 0.
	carts _ Dictionary new.
	users _ Dictionary new.
	books _ OrderedCollection new.! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 20:43:20'!
initializeWithUsers: aUserDictionary 
	users _ aUserDictionary .
	! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:36:33'!
listCart: aCartID

	self validateCartID: aCartID.
	^(self cart: aCartID) list.
	
	! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:24:56'!
validateBook: aBook
	
	(books includes: aBook)
		ifFalse: [ self error: self class invalidBookDescription ].! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:25:40'!
validateCartID: aCartID

	(carts includesKey: aCartID)
		ifFalse: [ self error: self class invalidCartDescription ].! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 19:24:43'!
validateExpiredCard: aCreditCardExpirationDate

	| expirationDateYearNumber expirationDateMonthNumber expirationDate |

	expirationDateYearNumber _ aCreditCardExpirationDate rem: 10000.
	expirationDateMonthNumber _ aCreditCardExpirationDate div: 10000.

	expirationDate _ DateAndTime year: expirationDateYearNumber month: expirationDateMonthNumber day: 1.
	
	(expirationDate  < DateAndTime  now) 
		ifTrue: [ self error: self class ExpiredCreditCardErrorDescription]! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:26:04'!
validateUser: aUser andPass: aPassword

	(users includesKey: aUser) ifFalse: [ self error: self class invalidUserOrPasswordDescription ].
	(users at: aUser) = aPassword ifFalse: [ self error: self class invalidUserOrPasswordDescription ].! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:04:41'!
withBooks: aBookDict
	
	books _ aBookDict! !

!ServerSimulator methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:04:46'!
withUsers: aUserDictionary
	users _ aUserDictionary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ServerSimulator class' category: #'TusLibros-Ejercicio'!
ServerSimulator class
	instanceVariableNames: ''!

!ServerSimulator class methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 19:25:57'!
ExpiredCreditCardErrorDescription
	^ 'Expired credit card'.! !

!ServerSimulator class methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:17:00'!
invalidBookDescription
	^ 'Invalid book'.! !

!ServerSimulator class methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:27:49'!
invalidCartDescription
	^ 'Invalid cart'.! !

!ServerSimulator class methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:16:41'!
invalidUserOrPasswordDescription
	^ 'Invalid user or password'.! !
