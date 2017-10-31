!classDefinition: #TusLibrosTest category: #'TusLibros-Ejercicio'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!TusLibrosTest methodsFor: 'createCart' stamp: 'GF 10/31/2017 00:16:53'!
test01createCartConIdentificacionValidaDevuelveUnaIDdeCarrito
	| server userDict cartID |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	server _ Market new withUsers: userDict.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'.
	self assert: cartID = 1.
	self assert: (server cart: 1) isEmpty.! !

!TusLibrosTest methodsFor: 'createCart' stamp: 'GF 10/31/2017 00:16:53'!
test02createCartConIdentificacionInvalidaDevuelveDescripcionDeError
	| server |
	server _ Market new.
	self
		should: [
			server
				createCartWithUser: 'pepe'
				andPass: 'pipo123' ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid user or password' ].! !


!TusLibrosTest methodsFor: 'addToCart' stamp: 'GF 10/31/2017 00:16:53'!
test03addToCartConDatosValidosAgregaCorrectamenteElLibroACarritoVacio
	| server userDict cartID bookDict |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ (Market new withUsers: userDict) withBooks: bookDict.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'.
	server
		addBook: 123
		withQuantity: 3
		toCart: cartID.
	self assert:
		((server cart: cartID)
			hasBook: 123
			times: 3).! !

!TusLibrosTest methodsFor: 'addToCart' stamp: 'GF 10/31/2017 00:16:53'!
test04addToCartConDatosValidosAgregaCorrectamenteUnLibroYaIncluido
	| server userDict cartID bookDict |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ (Market new withUsers: userDict) withBooks: bookDict.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'.
	server
		addBook: 123
		withQuantity: 3
		toCart: cartID.
	server
		addBook: 123
		withQuantity: 2
		toCart: cartID.
	self assert:
		((server cart: cartID)
			hasBook: 123
			times: 5).! !

!TusLibrosTest methodsFor: 'addToCart' stamp: 'GF 10/31/2017 00:16:53'!
test05addToCartConLibroInvalidoLevanteError
	| server userDict cartID bookDict |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	bookDict _ OrderedCollection new.
	server _ (Market new withUsers: userDict) withBooks: bookDict.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'.
	self
		should: [
			server
				addBook: 123
				withQuantity: 3
				toCart: cartID ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid book'.
			self assert: (server cart: cartID) isEmpty ].! !

!TusLibrosTest methodsFor: 'addToCart' stamp: 'GF 10/31/2017 00:16:53'!
test06addToCartConDatosValidosPeroCantidadInvalidaLevantaError
	| server userDict cartID bookDict |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ (Market new withUsers: userDict) withBooks: bookDict.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'.
	self
		should: [
			server
				addBook: 123
				withQuantity: -2
				toCart: cartID ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid quantity'.
			self assert: (server cart: cartID) isEmpty ].! !

!TusLibrosTest methodsFor: 'addToCart' stamp: 'GF 10/31/2017 00:16:53'!
test07addToCartConCarritoInvalidoLevantaError
	| server bookDict |
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ Market new withBooks: bookDict.
	self
		should: [
			server
				addBook: 123
				withQuantity: 1
				toCart: 123 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid cart' ].! !


!TusLibrosTest methodsFor: 'listCart' stamp: 'GF 10/31/2017 00:16:53'!
test08listCartDeCarritoVacioDevuelveUnaColeccionVacia
	| server userDict cartID bookDict |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ (Market new withUsers: userDict) withBooks: bookDict.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'.
	self assert: (server listCart: cartID) isEmpty.! !

!TusLibrosTest methodsFor: 'listCart' stamp: 'GF 10/31/2017 00:16:53'!
test09listCartDeCarritoConElementosListaLosLibrosAgregados
	| server userDict cartID bookDict expectedList |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	bookDict _ OrderedCollection new.
	bookDict add: 1.
	bookDict add: 2.
	server _ (Market new withUsers: userDict) withBooks: bookDict.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'.
	server
		addBook: 1
		withQuantity: 3
		toCart: cartID.
	server
		addBook: 2
		withQuantity: 2
		toCart: cartID.
	expectedList _ Dictionary new.
	expectedList
		at: 1
		put: 3.
	expectedList
		at: 2
		put: 2.
	self assert: expectedList = (server listCart: cartID).! !

!TusLibrosTest methodsFor: 'listCart' stamp: 'GF 10/31/2017 00:16:53'!
test10listCartDeCarritoInvalidoLevantaError
	| server |
	server _ Market new.
	self
		should: [ server listCart: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid cart' ].! !


!TusLibrosTest methodsFor: 'checkOutCart' stamp: 'GF 10/31/2017 00:56:26'!
test11checkOutConCarrritoVacioLevantaError
	| server userDict cartID creditCard |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	server _ Market new withUsers: userDict.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'.
		
	creditCard _ CreditCard withNumber: 123 
								   date: DateAndTime now yearNumber + 1 + 10000
								   andOwner: 'Pepito'.
								
	self
		should: [
			server checkOutCart: cartID withCreditCard: creditCard. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Empty cart' ].! !

!TusLibrosTest methodsFor: 'checkOutCart' stamp: 'GF 10/31/2017 00:16:53'!
test11checkOutConTarjetaVencidaLevantaError
	| server userDict cartID bookDict aCreditCardNumber aCreditCardExpirationDate aCreditCardOwner |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	bookDict _ OrderedCollection new.
	bookDict add: 123.
	server _ (Market new withUsers: userDict) withBooks: bookDict.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'.
	server
		addBook: 123
		withQuantity: 2
		toCart: cartID.
	aCreditCardNumber _ 123.
	aCreditCardExpirationDate _ DateAndTime now yearNumber - 1 + 10000.
	aCreditCardOwner _ 'Pepito'.
	self
		should: [
			server
				checkOutCart: cartID
				withCreditCardNumber: aCreditCardNumber
				withExpirationDate: aCreditCardExpirationDate
				andOwner: aCreditCardOwner ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Expired credit card' ].! !


!classDefinition: #Carto category: #'TusLibros-Ejercicio'!
Object subclass: #Carto
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:13:48'!
addBook: aBook times: aQuantity
	self validateQuantity: aQuantity.
	( books includesKey: aBook ) 
		ifTrue: [ books at: aBook put: ((books at: aBook) + aQuantity) ]
		ifFalse: [ books at: aBook put: aQuantity ]! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:10:21'!
hasBook: aBook times: aQuantity
	
	^ ( books at: aBook ) = aQuantity.! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:08:17'!
initialize

	books _ Dictionary new.! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:05:59'!
isEmpty
	
	^ books isEmpty.! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:36:45'!
list
	
	^ books! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 10/31/2017 00:55:01'!
validateNotEmpty
	
	self isEmpty
		ifTrue: [ self error: self class cartEmptyErrorDescription]! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:17:21'!
validateQuantity: aQuantity

	( aQuantity < 1 )
		ifTrue: [ self error: self class invalidQuantityDescription]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carto class' category: #'TusLibros-Ejercicio'!
Carto class
	instanceVariableNames: ''!

!Carto class methodsFor: 'as yet unclassified' stamp: 'GF 10/31/2017 00:55:43'!
cartEmptyErrorDescription
	
	^ 'Empty cart'! !

!Carto class methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:18:30'!
invalidQuantityDescription

	^ 'Invalid quantity'! !


!classDefinition: #Cashier category: #'TusLibros-Ejercicio'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'GF 10/31/2017 00:49:43'!
checkOutCart: aCart withCreditCard: aCreditCard 
	
	aCart validateNotEmpty.
	! !


!classDefinition: #CreditCard category: #'TusLibros-Ejercicio'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'GF 10/31/2017 00:42:51'!
initializeWithNumber: aNumber andDate: aDate andOwner: anOwner 
	
	number _ aNumber.
	expirationDate _ aDate.
	owner _ anOwner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Ejercicio'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'GF 10/31/2017 00:41:54'!
withNumber: aNumber date: aDate andOwner: anOwner
	
	^ self new initializeWithNumber: aNumber andDate: aDate andOwner: anOwner.! !


!classDefinition: #Market category: #'TusLibros-Ejercicio'!
Object subclass: #Market
	instanceVariableNames: 'users editorial lastCart carts books cashier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:24:12'!
addBook: aBook withQuantity: aQuantity toCart: aCartID
	
	self validateCartID: aCartID.
	self validateBook: aBook.
	(carts at: aCartID) addBook: aBook times: aQuantity.! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:32:57'!
cart: aCartID

	self validateCartID: aCartID.
	^ carts at: aCartID ! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/31/2017 00:52:42'!
checkOutCart: aCartID withCreditCard: aCreditCard

	cashier checkOutCart: (self cart: aCartID) withCreditCard: aCreditCard.! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/31/2017 00:12:50'!
createCartWith: aCartID
	carts
		at: aCartID
		put: Carto new.! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 21:25:47'!
createCartWithUser: aUser andPass: aPassword

	self validateUser: aUser andPass: aPassword.
	self createCartWith: (lastCart+1).
	lastCart _ lastCart + 1.
	^ lastCart.! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/31/2017 00:44:29'!
initialize
	
	lastCart _ 0.
	carts _ Dictionary new.
	users _ Dictionary new.
	books _ OrderedCollection new.
	cashier _ Cashier new.! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 20:43:20'!
initializeWithUsers: aUserDictionary 
	users _ aUserDictionary .
	! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:36:33'!
listCart: aCartID

	self validateCartID: aCartID.
	^(self cart: aCartID) list.
	
	! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:24:56'!
validateBook: aBook
	
	(books includes: aBook)
		ifFalse: [ self error: self class invalidBookDescription ].! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:25:40'!
validateCartID: aCartID

	(carts includesKey: aCartID)
		ifFalse: [ self error: self class invalidCartDescription ].! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 19:24:43'!
validateExpiredCard: aCreditCardExpirationDate

	| expirationDateYearNumber expirationDateMonthNumber expirationDate |

	expirationDateYearNumber _ aCreditCardExpirationDate rem: 10000.
	expirationDateMonthNumber _ aCreditCardExpirationDate div: 10000.

	expirationDate _ DateAndTime year: expirationDateYearNumber month: expirationDateMonthNumber day: 1.
	
	(expirationDate  < DateAndTime  now) 
		ifTrue: [ self error: self class ExpiredCreditCardErrorDescription]! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:26:04'!
validateUser: aUser andPass: aPassword

	(users includesKey: aUser) ifFalse: [ self error: self class invalidUserOrPasswordDescription ].
	(users at: aUser) = aPassword ifFalse: [ self error: self class invalidUserOrPasswordDescription ].! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:04:41'!
withBooks: aBookDict
	
	books _ aBookDict! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:04:46'!
withUsers: aUserDictionary
	users _ aUserDictionary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Market class' category: #'TusLibros-Ejercicio'!
Market class
	instanceVariableNames: ''!

!Market class methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 19:25:57'!
ExpiredCreditCardErrorDescription
	^ 'Expired credit card'.! !

!Market class methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:17:00'!
invalidBookDescription
	^ 'Invalid book'.! !

!Market class methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:27:49'!
invalidCartDescription
	^ 'Invalid cart'.! !

!Market class methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:16:41'!
invalidUserOrPasswordDescription
	^ 'Invalid user or password'.! !
