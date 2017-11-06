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

!MarketTest methodsFor: 'createCart' stamp: 'GF 11/5/2017 20:04:15'!
test01createCartConIdentificacionValidaCreaUnCarritoVacio
	| market userDict cartID  |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123'.
	
	market _ (Market new withUsers: userDict) withCartIDGenerator: CartIDSimulator new.
	
	cartID _ market createCartWithUser: 'pepe' andPass: 'pipo123' andTimeDuration: (Duration minutes: 30).
	
	self assert: (market listCart: cartID) isEmpty.! !

!MarketTest methodsFor: 'createCart' stamp: 'GF 11/5/2017 20:12:34'!
test02createCartConIdentificacionInvalidaDevuelveDescripcionDeError
	| market |
	market _ Market new.
	self should: [ market createCartWithUser: 'pepe'
							andPass: 'pipo123'
							andTimeDuration: (Duration minutes: 30). ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid user or password' ].! !


!MarketTest methodsFor: 'addToCart' stamp: 'GF 11/5/2017 20:14:32'!
test03addToCartConDatosValidosAgregaCorrectamenteElLibroACarritoVacio
	| server userDict cartID catalog |
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	server _ ((Market new withUsers: userDict) withCartIDGenerator: (CartIDSimulator new) )withBooksAndPrices: catalog.
	cartID _ server
		createCartWithUser: 'pepe'
		andPass: 'pipo123'
		andTimeDuration: (Duration minutes: 30).
	server
		addBook: 123
		withQuantity: 3
		toCart: cartID.
	
	self assert: ((server listCart: cartID) at: 123) = 3.! !

!MarketTest methodsFor: 'addToCart' stamp: 'GF 11/5/2017 20:20:24'!
test04addToCartConDatosValidosAgregaCorrectamenteUnLibroYaIncluido

	"Esto en necesario?"
	| server userDict cartID catalog |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	server _ ((Market new withUsers: userDict) withCartIDGenerator: (CartIDSimulator new)) withBooksAndPrices: catalog.
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
	
	self assert: (((server listCart: cartID) at: 123) = 5).! !

!MarketTest methodsFor: 'addToCart' stamp: 'GF 11/5/2017 20:17:23'!
test05addToCartConLibroInvalidoLevanteError
	| server userDict cartID |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	server _ (Market new withUsers: userDict) withCartIDGenerator: (CartIDSimulator new).
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
			self assert: (server listCart: cartID) isEmpty ].! !

!MarketTest methodsFor: 'addToCart' stamp: 'GF 11/5/2017 20:17:52'!
test06addToCartConDatosValidosPeroCantidadInvalidaLevantaError
	| server userDict cartID catalog |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	server _ ((Market new withUsers: userDict) withCartIDGenerator: (CartIDSimulator new)) withBooksAndPrices: catalog.
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
			self assert: (server listCart: cartID) isEmpty ].! !

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


!MarketTest methodsFor: 'listCart' stamp: 'GF 10/31/2017 00:16:53'!
test10listCartDeCarritoInvalidoLevantaError
	| server |
	server _ Market new.
	self
		should: [ server listCart: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid cart' ].! !


!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/5/2017 20:22:05'!
test09listCartDeCarritoConElementosListaLosLibrosAgregados
	| server userDict cartID catalog expectedList |
	
	userDict _ Dictionary new.
	userDict at: 'pepe' put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 1 put: 10 *peso.
	catalog at: 2 put: 15 *peso.
	server _ ((Market new withUsers: userDict) withCartIDGenerator: (CartIDSimulator new)) withBooksAndPrices: catalog.
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123' andTimeDuration: (Duration minutes: 30).
	server addBook: 1 withQuantity: 3 toCart: cartID.
	server addBook: 2 withQuantity: 2 toCart: cartID.
	
	expectedList _ Dictionary new.
	expectedList at: 1 put: 3.
	expectedList at: 2 put: 2.
	
	self assert: ((server listCart: cartID) = expectedList ).
	! !

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/5/2017 20:22:24'!
test11checkOutConCarritoVacioLevantaError
	| server userDict cartID creditCard |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	server _ (Market new withUsers: userDict) withCartIDGenerator: (CartIDSimulator new).
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

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/5/2017 20:22:40'!
test12checkOutConTarjetaVencidaLevantaError
	| server userDict cartID catalog creditCard |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	server _ ((Market new withUsers: userDict) withCartIDGenerator: (CartIDSimulator new)) withBooksAndPrices: catalog.
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

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/5/2017 21:49:01'!
test13checkOutConConDatosValidosContactaAlMerchantProcessor
	| market userDict cartID catalog creditCard merchant |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	merchant _ MerchantProcessorSimulator new.
	market _ (((Market new withUsers: userDict) withCartIDGenerator: (CartIDSimulator new)) withBooksAndPrices: catalog) withMerchant: merchant .
	cartID _ market
		createCartWithUser: 'pepe'
		andPass: 'pipo123'
		andTimeDuration: (Duration minutes: 30).
	market
		addBook: 123
		withQuantity: 2
		toCart: cartID.
		
	creditCard _ CreditCard withNumber: 123 
								   date: DateAndTime tomorrow
								   andOwner: 'Pepito'.
								
	market checkOutCart: cartID withCreditCard: creditCard.
	
	self assert: merchant wasContacted.! !

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/5/2017 20:23:39'!
test14checkOutConConDatosValidosContactaAlMerchantProcessorYDevuelveError
	| server userDict cartID catalog creditCard merchant |
	userDict _ Dictionary new.
	userDict
		at: 'pepe'
		put: 'pipo123'.
	catalog _ Dictionary new.
	catalog at: 123 put: 10 *peso.
	merchant _ MerchantProcessorSimulator new.
	server _ (((Market new withUsers: userDict) withCartIDGenerator: (CartIDSimulator new)) withBooksAndPrices: catalog) withMerchant: merchant .
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

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/5/2017 22:15:46'!
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
	server _ (((Market new withUsers: userDict) withCartIDGenerator: (CartIDSimulator new)) withBooksAndPrices: catalog) withMerchant: merchant .
	
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
 	self assert: pepeHistory totalAmount = (60*peso). ! !

!MarketTest methodsFor: 'checkOutCart' stamp: 'GF 11/5/2017 22:29:08'!
test17cartInvalidAfterLifespanHasEnded

	| cartID catalog server userDict password username |
	
	username _ 'pepe'.
	password _ 'pipo123'.
	userDict _ Dictionary new.
	userDict at: username put: password.
	
	catalog _ Dictionary new.
	catalog at: 1 put: 10 *peso.
	
	server _ ((Market new withUsers: userDict) withCartIDGenerator: (CartIDSimulator new)) withBooksAndPrices: catalog.
	
	cartID _ server createCartWithUser: 'pepe' andPass: 'pipo123' andTimeDuration: (Duration minutes: 0).
	
	self should: [ server addBook: 1 withQuantity: 3 toCart: cartID ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Expired cart' ].! !


!classDefinition: #CartIDSimulator category: #'TusLibros-Ejercicio'!
Object subclass: #CartIDSimulator
	instanceVariableNames: 'lastID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CartIDSimulator methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 20:11:14'!
initialize
	
	lastID _ 0! !

!CartIDSimulator methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 20:10:13'!
nextID
	
	lastID _ lastID + 1.
	^ lastID! !


!classDefinition: #Carto category: #'TusLibros-Ejercicio'!
Object subclass: #Carto
	instanceVariableNames: 'books id user timeToLive expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 22:34:41'!
addBook: aBook times: aQuantity
	self validateNotExpired.
	self validateQuantity: aQuantity.
	( books includesKey: aBook ) 
		ifTrue: [ books at: aBook put: ((books at: aBook) + aQuantity) ]
		ifFalse: [ books at: aBook put: aQuantity ].
	self updateExpirationDate.! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 17:24:38'!
books
	^books! !

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

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 22:33:33'!
list
	self validateNotExpired.
	self updateExpirationDate.
	^ books! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 22:35:06'!
totalWithCatalog: aCatalog
	self validateNotExpired.
	self updateExpirationDate.
	^ (books keys) inject: (0*peso) into: [ :amount :book | amount + ((aCatalog at:book)*(books at: book))]! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 22:34:18'!
updateExpirationDate
	
	expirationDate _ (DateAndTime now) + timeToLive.! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 17:24:15'!
user
	
	^ user! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 10/31/2017 00:55:01'!
validateNotEmpty
	
	self isEmpty
		ifTrue: [ self error: self class cartEmptyErrorDescription]! !

!Carto methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 22:20:42'!
validateNotExpired

	(DateAndTime now > expirationDate)
		 		ifTrue: [ self error: self class expiredCartErrorDescription ]
		! !

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

!Carto class methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 22:26:11'!
expiredCartErrorDescription
	
	^ 'Expired cart'! !

!Carto class methodsFor: 'as yet unclassified' stamp: 'GF 10/30/2017 16:18:30'!
invalidQuantityDescription

	^ 'Invalid quantity'! !

!Carto class methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 19:41:45'!
withID: aCartID andUser: aUsername andTimeToLive: aTimeDuration 
	
	^ self new initializeWithID: aCartID andUser: aUsername andTimeToLive: aTimeDuration.! !

!Carto class methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 22:26:08'!
xpiredCartErrorDescription
	
	^ 'Expired cart'! !


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
	instanceVariableNames: 'users editorial lastCart carts cashier catalog userPurchasesHistory cartIDGenerator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Market methodsFor: 'interface' stamp: 'GF 10/30/2017 16:24:12'!
addBook: aBook withQuantity: aQuantity toCart: aCartID
	
	self validateCartID: aCartID.
	self validateBook: aBook.
	(carts at: aCartID) addBook: aBook times: aQuantity.! !

!Market methodsFor: 'interface' stamp: 'GF 11/5/2017 20:02:07'!
checkOutCart: aCartID withCreditCard: aCreditCard

	^ cashier checkOutCart: (self cart: aCartID ) withCreditCard: aCreditCard.! !

!Market methodsFor: 'interface' stamp: 'GF 11/5/2017 20:08:31'!
createCartWithUser: aUser andPass: aPassword andTimeDuration: aTimeDuration

	| newID |
	
	self validateUser: aUser andPass: aPassword.
	newID _ cartIDGenerator nextID.
	carts at: newID put: (Carto withID: newID andUser: aUser andTimeToLive: aTimeDuration).

	^newID.! !

!Market methodsFor: 'interface' stamp: 'GF 11/5/2017 20:01:51'!
listCart: aCartID

	self validateCartID: aCartID.
	^(self cart: aCartID) list.
	
	! !

!Market methodsFor: 'interface' stamp: 'GF 11/2/2017 16:49:51'!
listPurchasesOf: aUsername withPassword: aPassword
	
	^ userPurchasesHistory at: aUsername! !


!Market methodsFor: 'private' stamp: 'GF 11/5/2017 20:02:58'!
cart: aCartID
	
	self validateCartID: aCartID .
	^ carts at: aCartID.! !

!Market methodsFor: 'private' stamp: 'GF 11/2/2017 17:17:39'!
catalog

	^catalog! !

!Market methodsFor: 'private' stamp: 'GF 11/5/2017 21:04:21'!
logPurchaseOfUser: aUsername andBooks: aPurchase andAmount: totalAmount 

	(userPurchasesHistory at: aUsername) addPurchase: aPurchase andAmount: totalAmount! !

!Market methodsFor: 'private' stamp: 'GF 11/2/2017 15:27:59'!
validateBook: aBook
	
	(catalog includesKey: aBook)
		ifFalse: [ self error: self class invalidBookDescription ].! !

!Market methodsFor: 'private' stamp: 'GF 10/30/2017 16:25:40'!
validateCartID: aCartID

	(carts includesKey: aCartID)
		ifFalse: [ self error: self class invalidCartDescription ].! !

!Market methodsFor: 'private' stamp: 'GF 10/30/2017 16:26:04'!
validateUser: aUser andPass: aPassword

	(users includesKey: aUser) ifFalse: [ self error: self class invalidUserOrPasswordDescription ].
	(users at: aUser) = aPassword ifFalse: [ self error: self class invalidUserOrPasswordDescription ].! !


!Market methodsFor: 'initialization' stamp: 'GF 11/5/2017 19:55:31'!
initialize
	
	lastCart _ 0.
	carts _ Dictionary new.
	users _ Dictionary new.
	catalog _ Dictionary new.
	cashier _ Cashier withMarket: self.
	userPurchasesHistory _ Dictionary new.! !

!Market methodsFor: 'initialization' stamp: 'GF 11/2/2017 15:21:35'!
withBooksAndPrices: aCatalog
	
	catalog _ aCatalog! !

!Market methodsFor: 'initialization' stamp: 'GF 11/5/2017 19:56:01'!
withCartIDGenerator: aCartIDSimulator 
	
	cartIDGenerator _ aCartIDSimulator ! !

!Market methodsFor: 'initialization' stamp: 'GF 11/2/2017 15:03:50'!
withMerchant: aMerchantProcessorSimulator 
	
	cashier withMerchant: aMerchantProcessorSimulator.! !

!Market methodsFor: 'initialization' stamp: 'GF 11/2/2017 16:20:12'!
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
	instanceVariableNames: 'wasContacted transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 21:27:20'!
debitFrom: aCreditCard amount: anAmountOfMoney 
	
	wasContacted  _ true.
	
	transactions add: (Transaction ofAmount: anAmountOfMoney withCreditCard: aCreditCard).
	( aCreditCard number = 1111)
		ifTrue: [ 
			self error: self class merchantProcessorErrorDescription ]
		ifFalse: [
			^ 1234 ]! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 21:29:06'!
initialize
	
	wasContacted _ false.
	transactions _ OrderedCollection new.! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 21:22:45'!
transactions

	^transactions! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 21:17:56'!
wasContacted
	
	^ wasContacted! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #'TusLibros-Ejercicio'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'GF 11/2/2017 16:02:02'!
merchantProcessorErrorDescription

	^ 'Error processing transaction'.! !


!classDefinition: #Transaction category: #'TusLibros-Ejercicio'!
Object subclass: #Transaction
	instanceVariableNames: 'amount creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Transaction methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 21:17:21'!
initializeWithAmount: anAmount withCreditCart: aCreditCard 
	
	amount _ anAmount .
	creditCard _ aCreditCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transaction class' category: #'TusLibros-Ejercicio'!
Transaction class
	instanceVariableNames: ''!

!Transaction class methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 21:23:48'!
ofAmount: anAmount withCreditCard: aCreditCard
	^ self new initializeWithAmount: anAmount withCreditCart: aCreditCard .! !


!classDefinition: #UserHistory category: #'TusLibros-Ejercicio'!
Object subclass: #UserHistory
	instanceVariableNames: 'books totalAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!UserHistory methodsFor: 'as yet unclassified' stamp: 'GF 11/5/2017 21:11:16'!
addPurchase: aPurchase andAmount: anAmount 
	
	totalAmount _ totalAmount + anAmount.
	
	(aPurchase keys) do: [ :aBook | 
		( books includesKey: aBook ) 
			ifTrue: [ books at: aBook put: ((books at: aBook) + (aPurchase at: aBook)) ]
			ifFalse: [ books at: aBook put: (aPurchase at: aBook) ]
			]! !

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
