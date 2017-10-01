!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!


!classDefinition: #ElevatorTest category: #'Elevator-Ejercicio'!
TestCase subclass: #ElevatorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:38'!
test09RequestToGoUpAreEnqueueWhenRequestedWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test10CabinDoorStartClosingAfterWaitingForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test11StopsWaitingForPeopleIfCloseDoorIsPressed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test12CloseDoorDoesNothingIfIdle

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController closeCabinDoor.

	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test13CloseDoorDoesNothingWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test14CloseDoorDoesNothingWhenOpeningTheDoorToWaitForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:42'!
test15ElevatorHasToEnterEmergencyIfStoppedAndOtherFloorSensorTurnsOn

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test16ElevatorHasToEnterEmergencyIfFalling

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test17ElevatorHasToEnterEmergencyIfJumpsFloors

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:3.
	elevatorController cabinDoorClosed.
	self 
		should: [ elevatorController cabinOnFloor: 3 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test18ElevatorHasToEnterEmergencyIfDoorClosesAutomatically
	| elevatorController |
	elevatorController := ElevatorController new.
	
	self 
		should: [ elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test19ElevatorHasToEnterEmergencyIfDoorClosedSensorTurnsOnWhenClosed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:49'!
test20ElevatorHasToEnterEmergencyIfDoorClosesWhenOpening
	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'.]! !


!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:35'!
test06DoorKeepsOpenedWhenOpeningIsRequested

	| elevatorController |
	elevatorController := ElevatorController new.
	
	self assert: elevatorController isCabinDoorOpened.
	
	elevatorController openCabinDoor.

	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 6/16/2014 13:24'!
test07DoorMustBeOpenedWhenCabinIsStoppedAndClosingDoors

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
		
	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.
! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:36'!
test08CanNotOpenDoorWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test09DoorKeepsOpeneingWhenItIsOpeneing

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test21CabinHasToStopOnTheFloorsOnItsWay
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test22ElevatorCompletesAllTheRequests
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:2.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test23CabinHasToStopOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test24CabinHasToStopAndWaitForPeopleOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !


!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/10/2011 17:33'!
test01ElevatorStartsIdleWithDoorOpenOnFloorZero

	| elevatorController |
		
	elevatorController := ElevatorController new.
		
	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.
	self assert: elevatorController cabinFloorNumber = 0
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:53'!
test02CabinDoorStartsClosingWhenElevatorGetsCalled

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self assert: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:57'!
test03CabinStartsMovingWhenDoorGetsClosed

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.

	self deny: elevatorController isCabinStopped.
	self assert: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test04CabinStopsAndStartsOpeningDoorWhenGetsToDestination

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.

	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
			
	self deny: elevatorController isCabinDoorOpened.
	self assert: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.

	self assert: elevatorController cabinFloorNumber = 1
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test05ElevatorGetsIdleWhenDoorGetOpened

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.
	elevatorController cabinDoorOpened.
		
	self assert: elevatorController isIdle.
	self deny: elevatorController isWorking.
		
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.

	self assert: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.
		
	self assert: elevatorController cabinFloorNumber = 1! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'state cabinState cabinDoorState cabinFloorNumber floorsToGo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:10:35'!
cabinDoorClosed
	
	cabinDoorState close: self.
	cabinState closeDoor: self.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:23:43'!
cabinFloorNumber

	^cabinFloorNumber! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:23:13'!
cabinOnFloor: aSmallInteger 
	
	cabinFloorNumber _ aSmallInteger.
	
	cabinState cabinOnFloor: aSmallInteger on: self.
	cabinDoorState cabinOnFloor: aSmallInteger on: self.
	state cabinOnFloor: aSmallInteger on: self.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:58:49'!
changeCabinDoorStateTo: anElevatorControllerCabinDoorState
	
	cabinDoorState _ anElevatorControllerCabinDoorState! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:13:46'!
changeCabinStateTo: anElevatorControllerCabinState
	
	cabinState _ anElevatorControllerCabinState ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:12:08'!
changeDoorStateTo: anElevatorControllerCabinDoorState
	
	cabinDoorState _ anElevatorControllerCabinDoorState ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:48:43'!
changeStateTo: anElevatorControllerState
	
	state _ anElevatorControllerState! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:56:24'!
goUpPushedFromFloor: aSmallInteger 
	
	state goUpPushedFromFloor: aSmallInteger on: self.
	cabinState goUpPushedFromFloor: aSmallInteger on: self.
	cabinDoorState goUpPushedFromFloor: aSmallInteger on: self.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:23:15'!
initialize

	state _ ElevatorControllerIdle new.
	cabinState _ ElevatorControllerCabinStopped new.
	cabinDoorState _ ElevatorControllerCabinDoorOpened new.
	cabinFloorNumber _ 0.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:01:24'!
isCabinDoorClosed
	
	^ cabinDoorState isClosed! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:00:37'!
isCabinDoorClosing
	
	^ cabinDoorState isClosing! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:20:05'!
isCabinDoorOpened
	
	^ cabinDoorState isOpen.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:59:45'!
isCabinDoorOpening
	
	^ cabinDoorState isOpening.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:52:23'!
isCabinMoving
	
	^ cabinState isMoving! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:15:42'!
isCabinStopped
	
	^ cabinState isStopped! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:07:20'!
isIdle
	
	^ state isIdle! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:51:36'!
isWorking
	
	^ state isWorking! !


!classDefinition: #ElevatorControllerCabinDoorState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorControllerCabinDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:25:40'!
cabinOnFloor: aSmallInteger on: anElevatorController 
	
	^ self subclassResponsibility ! !

!ElevatorControllerCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:10:49'!
close: anElevatorController 
	
	^ self subclassResponsibility ! !

!ElevatorControllerCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:56:56'!
goUpPushedFromFloor: aSmallInteger on: anElevatorController 
	
	^ self subclassResponsibility ! !

!ElevatorControllerCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:01:46'!
isClosed
	
	^ self subclassResponsibility ! !

!ElevatorControllerCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:00:51'!
isClosing
	
	^ self subclassResponsibility ! !

!ElevatorControllerCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:21:14'!
isOpen
	
	^ self subclassResponsibility ! !

!ElevatorControllerCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:00:06'!
isOpening
	
	^ self subclassResponsibility ! !


!classDefinition: #ElevatorControllerCabinDoorClosed category: #'Elevator-Ejercicio'!
ElevatorControllerCabinDoorState subclass: #ElevatorControllerCabinDoorClosed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerCabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:26:15'!
cabinOnFloor: aSmallInteger on: anElevatorController 
	
	anElevatorController changeDoorStateTo: ( ElevatorControllerCabinDoorOpening new )! !

!ElevatorControllerCabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:15:04'!
isClosed
	
	^ true! !

!ElevatorControllerCabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:14:55'!
isClosing
	
	^ false! !

!ElevatorControllerCabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:14:36'!
isOpen
	
	^ false! !

!ElevatorControllerCabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:14:45'!
isOpening
	
	^ false! !


!classDefinition: #ElevatorControllerCabinDoorClosing category: #'Elevator-Ejercicio'!
ElevatorControllerCabinDoorState subclass: #ElevatorControllerCabinDoorClosing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerCabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:11:29'!
close: anElevatorController 
	
	anElevatorController changeDoorStateTo: ( ElevatorControllerCabinDoorClosed new )! !

!ElevatorControllerCabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:01:58'!
isClosed
	
	^ false! !

!ElevatorControllerCabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:01:02'!
isClosing
	
	^ true! !

!ElevatorControllerCabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:59:06'!
isOpen
	
	^ false! !


!ElevatorControllerCabinDoorClosing methodsFor: 'associating' stamp: 'GF 10/1/2017 02:00:19'!
isOpening
	
	^ false! !


!classDefinition: #ElevatorControllerCabinDoorOpened category: #'Elevator-Ejercicio'!
ElevatorControllerCabinDoorState subclass: #ElevatorControllerCabinDoorOpened
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerCabinDoorOpened methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:57:57'!
goUpPushedFromFloor: aSmallInteger on: anElevatorController 
	
	anElevatorController changeCabinDoorStateTo: (ElevatorControllerCabinDoorClosing new )! !

!ElevatorControllerCabinDoorOpened methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:21:24'!
isOpen
	
	^ true! !


!classDefinition: #ElevatorControllerCabinDoorOpening category: #'Elevator-Ejercicio'!
ElevatorControllerCabinDoorState subclass: #ElevatorControllerCabinDoorOpening
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerCabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:27:59'!
isClosed
	
	^ false! !

!ElevatorControllerCabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:27:51'!
isClosing
	
	^ false! !

!ElevatorControllerCabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:27:22'!
isOpen
	
	^ false! !

!ElevatorControllerCabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:27:40'!
isOpening
	
	^ true! !


!classDefinition: #ElevatorControllerCabinState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorControllerCabinState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerCabinState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:24:02'!
cabinOnFloor: aSmallInteger on: anElevatorController 
	
	^ self subclassResponsibility ! !

!ElevatorControllerCabinState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:12:21'!
closeDoor: anElevatorController 
	
	^ self subclassResponsibility ! !

!ElevatorControllerCabinState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:55:10'!
goUpPushedFromFloor: aSmallInteger on: anElevatorController 
	
	^ self subclassResponsibility ! !

!ElevatorControllerCabinState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:52:53'!
isMoving
	
	^ self subclassResponsibility ! !

!ElevatorControllerCabinState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:17:31'!
isStopped
	
	^ self subclassResponsibility ! !


!classDefinition: #ElevatorControllerCabinMoving category: #'Elevator-Ejercicio'!
ElevatorControllerCabinState subclass: #ElevatorControllerCabinMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerCabinMoving methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:25:27'!
cabinOnFloor: aSmallInteger on: anElevatorController 
	
	anElevatorController changeCabinStateTo: ( ElevatorControllerCabinStopped new )! !

!ElevatorControllerCabinMoving methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:14:22'!
isMoving
	
	^ true! !

!ElevatorControllerCabinMoving methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:14:09'!
isStopped
	
	^ false! !


!classDefinition: #ElevatorControllerCabinStopped category: #'Elevator-Ejercicio'!
ElevatorControllerCabinState subclass: #ElevatorControllerCabinStopped
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerCabinStopped methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:13:07'!
closeDoor: anElevatorController 
	
	anElevatorController changeCabinStateTo: ( ElevatorControllerCabinMoving new ).! !

!ElevatorControllerCabinStopped methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:55:48'!
goUpPushedFromFloor: aSmallInteger on: anElevatorController ! !

!ElevatorControllerCabinStopped methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:53:09'!
isMoving
	
	^ false! !

!ElevatorControllerCabinStopped methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:18:11'!
isStopped
	
	^ true! !


!classDefinition: #ElevatorControllerState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorControllerState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:26:45'!
cabinOnFloor: aSmallInteger on: anElevatorController 
	
	^ self subclassResponsibility ! !

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:08:10'!
isIdle

	^ self subclassResponsibility ! !

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:51:01'!
isWorking

	^ self subclassResponsibility ! !


!classDefinition: #ElevatorControllerIdle category: #'Elevator-Ejercicio'!
ElevatorControllerState subclass: #ElevatorControllerIdle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerIdle methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:47:59'!
goUpPushedFromFloor: aSmallInteger on: anElevatorController 
	
	anElevatorController changeStateTo: ( ElevatorControllerWorking new ).! !

!ElevatorControllerIdle methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:14:33'!
isIdle
	
	^ true! !


!classDefinition: #ElevatorControllerWorking category: #'Elevator-Ejercicio'!
ElevatorControllerState subclass: #ElevatorControllerWorking
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerWorking methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 02:27:05'!
cabinOnFloor: aSmallInteger on: anElevatorController ! !

!ElevatorControllerWorking methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:49:12'!
isIdle
	
	^ false! !

!ElevatorControllerWorking methodsFor: 'as yet unclassified' stamp: 'GF 10/1/2017 01:51:50'!
isWorking
	
	^ true! !
