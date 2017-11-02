!classDefinition: #CartTest category: #'TusLibros-Ejercicio'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!


!classDefinition: #MarketTest category: #'TusLibros-Ejercicio'!
TestCase subclass: #MarketTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!MarketTest methodsFor: 'createCart' stamp: 'GF 11/2/2017 19:55:16'!
test01createCartConIdentificacionValidaDevuelveUnaIDdeCarrito
	| server userDict cartID |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	server _ Market new withUsers: userDict.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'
		andTimeDuration: (Duration minutes: 30).
	self assert: cartID = 1.
	self assert: (server cart: 1) isEmpty.! !

!MarketTest methodsFor: 'createCart' stamp: 'GF 11/2/2017 19:55:26'!
test02createCartConIdentificacionInvalidaDevuelveDescripcionDeError
	| server |
	server _ Market new.
	self
		should: [
			server
				createCartWithUser: 'pepe'
				andPass: 'pipo123'
				andTimeDuration: (Duration minutes: 30). ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid user or password' ].! !


!MarketTest methodsFor: 'addToCart' stamp: 'GF 11/2/2017 19:55:34'!
test03addToCartConDatosValidosAgregaCorrectamenteElLibroACarritoVacio
	| server userDict cartID catalog |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	server _ (Market new withUsers: userDict) withBooksAndPrices: catalog.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'
		andTimeDuration: (Duration minutes: 30).
	server
		addBook: 123
		withQuantity: 3
		toCart: cartID.
	self assert:
		((server cart: cartID)
			hasBook: 123
			times: 3).! !

!MarketTest methodsFor: 'addToCart' stamp: 'GF 11/2/2017 19:55:40'!
test04addToCartConDatosValidosAgregaCorrectamenteUnLibroYaIncluido
	| server userDict cartID catalog |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	server _ (Market new withUsers: userDict) withBooksAndPrices: catalog.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'
		andTimeDuration: (Duration minutes: 30).
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

!MarketTest methodsFor: 'addToCart' stamp: 'GF 11/2/2017 19:55:48'!
test05addToCartConLibroInvalidoLevanteError
	| server userDict cartID |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	server _ (Market new withUsers: userDict).
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'
		andTimeDuration: (Duration minutes: 30).
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

!MarketTest methodsFor: 'addToCart' stamp: 'GF 11/2/2017 19:55:53'!
test06addToCartConDatosValidosPeroCantidadInvalidaLevantaError
	| server userDict cartID catalog |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	server _ (Market new withUsers: userDict) withBooksAndPrices: catalog.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'
		andTimeDuration: (Duration minutes: 30).
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

!MarketTest methodsFor: 'addToCart' stamp: 'GF 11/2/2017 15:24:19'!
test07addToCartConCarritoInvalidoLevantaError
	| server catalog |
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	server _ (Market new) withBooksAndPrices: catalog.
	self
		should: [
			server
				addBook: 123
				withQuantity: 1
				toCart: 123 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid cart' ].! !


!MarketTest methodsFor: 'listCart' stamp: 'GF 11/2/2017 19:56:02'!
test08listCartDeCarritoVacioDevuelveUnaColeccionVacia
	| server userDict cartID |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	server _ Market new withUsers: userDict.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'
		andTimeDuration: (Duration minutes: 30).
		
	self assert: (server listCart: cartID) isEmpty.! !

!MarketTest methodsFor: 'listCart' stamp: 'GF 10/31/2017 00:16:53'!
test10listCartDeCarritoInvalidoLevantaError
	| server |
	server _ Market new.
	self
		should: [ server listCart: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid cart' ].! !


!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/2/2017 19:56:12'!
test09listCartDeCarritoConElementosListaLosLibrosAgregados
	| server userDict cartID catalog expectedList |
	
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 1 put: 10 *peso.
	catalog at: 2 put: 15 *peso.
	server _ (Market new withUsers: userDict) withBooksAndPrices: catalog.
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123' andTimeDuration: (Duration minutes: 30).
	server addBook: 1 withQuantity: 3 toCart: cartID.
	server addBook: 2 withQuantity: 2 toCart: cartID.
	
	expectedList _ Dictionary new.
	expectedList at: 1 put: 3.
	expectedList at: 2 put: 2.
	
	self assert: ((server listCart: cartID) = expectedList ).
	! !

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/2/2017 19:56:19'!
test11checkOutConCarritoVacioLevantaError
	| server userDict cartID creditCard |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	server _ Market new withUsers: userDict.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'
		andTimeDuration: (Duration minutes: 30).
		
	creditCard _ CreditCard withNumber: 123 
								   date: DateAndTime tomorrow
								   andOwner: 'Pepito'.
								
	self
		should: [
			server checkOutCart: cartID withCreditCard: creditCard. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Empty cart' ].! !

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/2/2017 19:56:23'!
test12checkOutConTarjetaVencidaLevantaError
	| server userDict cartID catalog creditCard |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	server _ (Market new withUsers: userDict) withBooksAndPrices: catalog.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'
		andTimeDuration: (Duration minutes: 30).
	server
		addBook: 123
		withQuantity: 2
		toCart: cartID.
		
	creditCard _ CreditCard withNumber: 123 
								   date: DateAndTime yesterday
								   andOwner: 'Pepito'.
				
	self
		should: [
			server
				checkOutCart: cartID
				withCreditCard: creditCard ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Expired credit card' ].! !

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/2/2017 19:56:27'!
test13checkOutConConDatosValidosContactaAlMerchantProcessorYDevuelveTransactionID
	| server userDict cartID catalog creditCard merchant |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	merchant _ MerchantProcessorSimulator new.
	server _ ((Market new withUsers: userDict) withBooksAndPrices: catalog) withMerchant: merchant .
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'
		andTimeDuration: (Duration minutes: 30).
	server
		addBook: 123
		withQuantity: 2
		toCart: cartID.
		
	creditCard _ CreditCard withNumber: 123 
								   date: DateAndTime tomorrow
								   andOwner: 'Pepito'.
				
	self assert: (1234 = (server checkOutCart: cartID withCreditCard: creditCard))! !

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/2/2017 19:56:33'!
test14checkOutConConDatosValidosContactaAlMerchantProcessorYDevuelveError
	| server userDict cartID catalog creditCard merchant |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	merchant _ MerchantProcessorSimulator new.
	server _ ((Market new withUsers: userDict) withBooksAndPrices: catalog) withMerchant: merchant .
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'
		andTimeDuration: (Duration minutes: 30).
	server
		addBook: 123
		withQuantity: 2
		toCart: cartID.
		
	creditCard _ CreditCard withNumber: 1111
								   date: DateAndTime tomorrow
								   andOwner: 'Pepito'.
								
	self
		should: [
			server
				checkOutCart: cartID
				withCreditCard: creditCard ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Error processing transaction' ].! !

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/2/2017 17:18:41'!
test15listPurchasesOfAUserWhithoutPurchasesReturnsAnEmptyCollection

	| server userDict pepeHistory |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	server _ Market new withUsers: userDict.
	
	pepeHistory _ server listPurchasesOf: 'pepe' withPassword: 'pipo123'.
	
	self assert: pepeHistory bookList isEmpty.
	self assert: pepeHistory totalAmount = 0. ! !

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/2/2017 19:56:38'!
test16listPurchasesOfAUserWhithPurchasesReturnsCorrectHistory

	| cartID catalog expectedList pepeHistory server userDict creditCard password username merchant |
	
	username _ 'pepe'.
	password _ 'pipo123'.
	userDict _ Dictionary new.
	userDict at: username put: password.
	
	catalog _ Dictionary new.
	catalog at: 1 put: 10 *peso.
	catalog at: 2 put: 15 *peso.
	
	merchant _ MerchantProcessorSimulator new.
	server _ ((Market new withUsers: userDict) withBooksAndPrices: catalog) withMerchant: merchant .
	
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123' andTimeDuration: (Duration minutes: 30).
	server addBook: 1 withQuantity: 3 toCart: cartID.
	server addBook: 2 withQuantity: 2 toCart: cartID.
	creditCard _ CreditCard withNumber: 123 date: DateAndTime tomorrow andOwner: 'Pepito'.
	server checkOutCart: cartID withCreditCard: creditCard.
									
	expectedList _ Dictionary new.
	expectedList at: 1 put: 3.
	expectedList at: 2 put: 2.
	
	pepeHistory _ server listPurchasesOf: username withPassword: password.
	self assert: (pepeHistory bookList) = expectedList.
 	self assert: pepeHistory totalAmount = 60. ! !

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/2/2017 19:57:27'!
test17cartInvalidAfterLifespanHasEnded

	| cartID catalog server userDict password username |
	
	username _ 'pepe'.
	password _ 'pipo123'.
	userDict _ Dictionary new.
	userDict at: username put: password.
	
	catalog _ Dictionary new.
	catalog at: 1 put: 10 *peso.
	
	server _ (Market new withUsers: userDict) withBooksAndPrices: catalog.
	
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123' andTimeDuration: (Duration minutes: 0).
	server addBook: 1 withQuantity: 3 toCart: cartID.
	
	! !


!classDefinition: #Carto category: #'TusLibros-Ejercicio'!
Object subclass: #Carto
	instanceVariableNames: 'books id user timeToLive expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:13:48'!
addBook: aBook times: aQuantity
	self validateQuantity: aQuantity.
	( books includesKey: aBook ) 
		ifTrue: [ books at: aBook put: ((books at: aBook) + aQuantity) ]
		ifFalse: [ books at: aBook put: aQuantity ]! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 17:24:38'!
books
	^books! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 10/29/2017 22:10:21'!
hasBook: aBook times: aQuantity
	
	^ ( books at: aBook ) = aQuantity.! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 19:43:43'!
initialize

	books _ Dictionary new.! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 19:48:09'!
initializeWithID: aCartID andUser: aUsername andTimeToLive: aTimeDuration 
	
	id _ aCartID.
	user _ aUsername.
	timeToLive _ aTimeDuration.
	expirationDate _ (DateAndTime now) + aTimeDuration.! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:05:59'!
isEmpty
	
	^ books isEmpty.! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:36:45'!
list
	
	^ books! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 15:12:16'!
total
	self shouldBeImplemented.! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 15:44:02'!
totalWithCatalog: aCatalog

	^ (books keys) inject: (0*peso) into: [ :amount :book | amount + (aCatalog at:book)*(books at: book) ].! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 17:24:15'!
user
	
	^ user! !

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

!Carto class methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 19:41:45'!
withID: aCartID andUser: aUsername andTimeToLive: aTimeDuration 
	
	^ self new initializeWithID: aCartID andUser: aUsername andTimeToLive: aTimeDuration.! !


!classDefinition: #Cashier category: #'TusLibros-Ejercicio'!
Object subclass: #Cashier
	instanceVariableNames: 'merchant market'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 17:23:39'!
checkOutCart: aCart withCreditCard: aCreditCard
	
	| purchaseAmount transactionID |
	aCart validateNotEmpty.
	aCreditCard validateNotExpired: DateAndTime now.
	
	purchaseAmount _ aCart totalWithCatalog: market catalog.
	transactionID _ merchant debitFrom: aCreditCard amount: purchaseAmount.
	
	market logPurchaseOfUser: aCart user andBooks: aCart books andAmount: purchaseAmount.
	
	^ transactionID! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 17:15:20'!
initializeWithMarket: aMarket

	market _ aMarket ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 15:04:02'!
withMerchant: aMerchantProcessorSimulator 
	
	merchant _ aMerchantProcessorSimulator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Ejercicio'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 17:14:17'!
withMarket: aMarket
	
	^ self new initializeWithMarket: aMarket.! !


!classDefinition: #CreditCard category: #'TusLibros-Ejercicio'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 14:52:35'!
initializeWithNumber: aNumber andDate: aDate andOwner: anOwner 
	
	number _ aNumber.
	expirationDate _ aDate.
	owner _ anOwner.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 15:58:35'!
number
	^number! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 14:56:49'!
validateNotExpired: aDateAndTime 
	
	( aDateAndTime < expirationDate )
		ifFalse: [ self error: self class expiredCreditCardErrorDescription]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Ejercicio'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 14:57:50'!
expiredCreditCardErrorDescription
	
	^ 'Expired credit card'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'GF 10/31/2017 00:41:54'!
withNumber: aNumber date: aDate andOwner: anOwner
	
	^ self new initializeWithNumber: aNumber andDate: aDate andOwner: anOwner.! !


!classDefinition: #Market category: #'TusLibros-Ejercicio'!
Object subclass: #Market
	instanceVariableNames: 'users editorial lastCart carts cashier catalog userPurchasesHistory'
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

!Market methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 17:17:39'!
catalog

	^catalog! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 17:17:19'!
checkOutCart: aCartID withCreditCard: aCreditCard

	^ cashier checkOutCart: (self cart: aCartID) withCreditCard: aCreditCard.! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 19:39:32'!
createCartWith: aCartID andUser: aUsername andTimeToLive: aTimeDuration
	carts
		at: aCartID
		put: (Carto withID: aCartID andUser: aUsername andTimeToLive: aTimeDuration).! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 19:53:36'!
createCartWithUser: aUser andPass: aPassword andTimeDuration: aDuration

	self validateUser: aUser andPass: aPassword.
	self createCartWith: (lastCart+1) andUser: aUser andTimeToLive: aDuration.
	lastCart _ lastCart + 1.
	^ lastCart.! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 17:13:19'!
initialize
	
	lastCart _ 0.
	carts _ Dictionary new.
	users _ Dictionary new.
	catalog _ Dictionary new.
	cashier _ Cashier withMarket: self.
	userPurchasesHistory _ Dictionary new.! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:36:33'!
listCart: aCartID

	self validateCartID: aCartID.
	^(self cart: aCartID) list.
	
	! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 16:49:51'!
listPurchasesOf: aUsername withPassword: aPassword
	
	^ userPurchasesHistory at: aUsername! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 17:31:50'!
logPurchaseOfUser: aUsername andBooks: aPurchase andAmount: totalAmount 

	self shouldBeImplemented! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 15:27:59'!
validateBook: aBook
	
	(catalog includesKey: aBook)
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

!Market methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 15:21:35'!
withBooksAndPrices: aCatalog
	
	catalog _ aCatalog! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 15:03:50'!
withMerchant: aMerchantProcessorSimulator 
	
	cashier withMerchant: aMerchantProcessorSimulator.! !

!Market methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 16:20:12'!
withUsers: aUserDictionary
	
	users _ aUserDictionary.
	
	(users keys) do: [ :user | 
		userPurchasesHistory at: user put: UserHistory new.
		].! !

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


!classDefinition: #MerchantProcessorSimulator category: #'TusLibros-Ejercicio'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 16:01:22'!
debitFrom: aCreditCard amount: anAmountOfMoney 
	
	 ( aCreditCard number = 1111)
		ifTrue: [ 
			self error: self class merchantProcessorErrorDescription ]
		ifFalse: [
			^ 1234 ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #'TusLibros-Ejercicio'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 16:02:02'!
merchantProcessorErrorDescription

	^ 'Error processing transaction'.! !


!classDefinition: #UserHistory category: #'TusLibros-Ejercicio'!
Object subclass: #UserHistory
	instanceVariableNames: 'books totalAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!UserHistory methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 16:23:07'!
bookList
	
	^ books! !

!UserHistory methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 16:24:35'!
initialize
	
	books _ Dictionary new.
	totalAmount _ 0.! !

!UserHistory methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 16:24:10'!
totalAmount
	
	^ totalAmount! !
