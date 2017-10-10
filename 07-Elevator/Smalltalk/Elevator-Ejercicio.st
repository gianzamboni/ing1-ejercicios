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


!classDefinition: #ElevatorCabinController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorCabinController
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:43:26'!
cabinDoorClosed: anElevatorController 
	
	state cabinDoorClosed: self.! !

!ElevatorCabinController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:47:42'!
cabinDoorClosedAsCabinStopped
	
	state _ ElevatorCabinMoving new! !

!ElevatorCabinController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:32:47'!
cabinDoorOpened: anElevatorController 
	
	state cabinDoorOpened: self.! !

!ElevatorCabinController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:33:30'!
cabinDoorOpenedWhileStopped
	
	! !

!ElevatorCabinController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:16:24'!
cabinOnFloor: aSmallInteger as: anElevatorController 
	state cabinOnFloor: aSmallInteger as: self ! !

!ElevatorCabinController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:18:26'!
cabinOnFloorWhileCabinMoving
	state _ ElevatorCabinStopped new! !

!ElevatorCabinController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:00:27'!
initialize 

	state _ ElevatorCabinStopped new! !

!ElevatorCabinController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:09:24'!
isMoving
	
	^ state isMoving! !

!ElevatorCabinController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 20:49:26'!
isStopped
	
	^ state isStopped.! !

!ElevatorCabinController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:44:02'!
openCabinDoor: anElevatorController 
	
	state openCabinDoor: self.! !

!ElevatorCabinController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:59:50'!
openCabinDoorWhileMoving
	
	! !

!ElevatorCabinController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:44:48'!
openCabinDoorWhileStopped
	
	! !


!classDefinition: #ElevatorCabinDoorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorCabinDoorController
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:52:26'!
cabinDoorClosed: anElevatorController 
	
	state cabinDoorClosed: self.! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:50:37'!
cabinDoorClosedAsDoorIsClosing
	
	state _ ElevatorCabinDoorClosed new! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:34:20'!
cabinDoorOpened: anElevatorController 
	
	state cabinDoorOpened: self.! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:35:41'!
cabinDoorOpenedWhileOpening
	
	state _ ElevatorCabinDoorOpened.! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:20:45'!
cabinOnFloor: aSmallInteger as: anElevatorController 
	state cabinOnFloor: aSmallInteger  as: self ! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:23:35'!
cabinOnFloorWithDoorClosed
	
	state _ ElevatorCabinDoorOpening new.! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:14:35'!
goUpPushedFromFloor: aSmallInteger on: anElevatorController 
	
	state goUpPushedFromFloor: self ! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:16:01'!
goUpPushedWhileOpened
	
	state _ ElevatorCabinDoorClosing new! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 20:50:32'!
initialize

	state _ ( ElevatorCabinDoorOpened new )! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:18:40'!
isClosed
	
	^ state isClosed! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:18:09'!
isClosing
	
	^ state isClosing! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:02:15'!
isOpened
	
	^ state isOpened! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:27:58'!
isOpening
	
	^ state isOpening.! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:45:17'!
openCabinDoor: anElevatorController 
	
	state openCabinDoor: self.! !

!ElevatorCabinDoorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:45:43'!
openCabinDoorWhileOpening
	
	! !


!classDefinition: #ElevatorCabinDoorState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorCabinDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:49:23'!
CabinDoorClosed: anElevatorCabinDoorController 
	
	^ self subclassResponsibility ! !

!ElevatorCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:34:49'!
cabinDoorOpened: anElevatorCabinDoorController 
	
	anElevatorCabinDoorController cabinDoorOpenedWhileOpening.! !

!ElevatorCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:21:47'!
cabinOnFloor: aSmallInteger as: anElevatorCabinDoorController 
	
	^ self subclassResponsibility ! !

!ElevatorCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:14:47'!
goUpPushedFromFloor: anElevatorCabinDoorController 
	
	^ self subclassResponsibility ! !

!ElevatorCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:18:48'!
isClosed
	
	^ self subclassResponsibility ! !

!ElevatorCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:17:16'!
isClosing
	
	^ self subclassResponsibility ! !

!ElevatorCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:02:27'!
isOpened
	
	^ self subclassResponsibility ! !

!ElevatorCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:28:56'!
isOpening
	
	^ self subclassResponsibility ! !

!ElevatorCabinDoorState methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:45:33'!
openCabinDoor: anElevatorCabinDoorController 
	
	anElevatorCabinDoorController openCabinDoorWhileOpening.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorCabinDoorState class' category: #'Elevator-Ejercicio'!
ElevatorCabinDoorState class
	instanceVariableNames: ''!

!ElevatorCabinDoorState class methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:40:15'!
isClosed
	
	^ self subclassResponsibility ! !

!ElevatorCabinDoorState class methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:39:52'!
isClosing
	
	^ self subclassResponsibility ! !

!ElevatorCabinDoorState class methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:38:32'!
isOpened
	
	^ self subclassResponsibility ! !

!ElevatorCabinDoorState class methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:39:22'!
isOpening
	
	^ self subclassResponsibility ! !


!classDefinition: #ElevatorCabinDoorClosed category: #'Elevator-Ejercicio'!
ElevatorCabinDoorState subclass: #ElevatorCabinDoorClosed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:23:09'!
cabinOnFloor: aSmallInteger as: anElevatorCabinDoorController 
	
	anElevatorCabinDoorController cabinOnFloorWithDoorClosed.! !

!ElevatorCabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:52:59'!
isClosed
	
	^ true! !

!ElevatorCabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:52:36'!
isClosing
	
	^ false! !

!ElevatorCabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:51:09'!
isOpened
	
	^ false! !

!ElevatorCabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:46:21'!
isOpening
	
	^ false! !


!classDefinition: #ElevatorCabinDoorClosing category: #'Elevator-Ejercicio'!
ElevatorCabinDoorState subclass: #ElevatorCabinDoorClosing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:51:58'!
cabinDoorClosed: anElevatorCabinDoorController
	anElevatorCabinDoorController cabinDoorClosedAsDoorIsClosing.! !

!ElevatorCabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:18:57'!
isClosed
	
	^ false! !

!ElevatorCabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:17:25'!
isClosing
	
	^ true! !

!ElevatorCabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:16:10'!
isOpened
	
	^ false! !

!ElevatorCabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:46:10'!
isOpening
	
	^false! !


!classDefinition: #ElevatorCabinDoorOpened category: #'Elevator-Ejercicio'!
ElevatorCabinDoorState subclass: #ElevatorCabinDoorOpened
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinDoorOpened methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:15:31'!
goUpPushedFromFloor: anElevatorCabinDoorController 
	
	anElevatorCabinDoorController goUpPushedWhileOpened.! !

!ElevatorCabinDoorOpened methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:02:35'!
isOpened
	
	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorCabinDoorOpened class' category: #'Elevator-Ejercicio'!
ElevatorCabinDoorOpened class
	instanceVariableNames: ''!

!ElevatorCabinDoorOpened class methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:40:26'!
isClosed
	
	^ false! !

!ElevatorCabinDoorOpened class methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:40:01'!
isClosing
	
	^ false! !

!ElevatorCabinDoorOpened class methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:39:10'!
isOpened
	
	^ true! !

!ElevatorCabinDoorOpened class methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:39:35'!
isOpening
	
	^ false! !


!classDefinition: #ElevatorCabinDoorOpening category: #'Elevator-Ejercicio'!
ElevatorCabinDoorState subclass: #ElevatorCabinDoorOpening
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:30:16'!
isClosed
	
	^ false! !

!ElevatorCabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:29:40'!
isClosing
	
	^ false! !

!ElevatorCabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:23:45'!
isOpened
	
	^ false! !

!ElevatorCabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:29:11'!
isOpening
	
	^ true! !


!classDefinition: #ElevatorCabinState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorCabinState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinState methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:46:32'!
cabinDoorClosed: anElevatorCabinController 
	
	anElevatorCabinController cabinDoorClosedAsCabinStopped.! !

!ElevatorCabinState methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:32:56'!
cabinDoorOpened: anElevatorCabinController 
	
	^ self subclassResponsibility ! !

!ElevatorCabinState methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:14:14'!
cabinOnFloor: aSmallInteger as: anElevatorController 
	^self subclassResponsibility ! !

!ElevatorCabinState methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:09:34'!
isMoving
	
	^ self subclassResponsibility ! !

!ElevatorCabinState methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:00:40'!
isStopped
	
	^ self subclassResponsibility ! !

!ElevatorCabinState methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:59:02'!
openCabinDoor: anElevatorCabinController 
	
	^ self subclassResponsibility ! !


!classDefinition: #ElevatorCabinMoving category: #'Elevator-Ejercicio'!
ElevatorCabinState subclass: #ElevatorCabinMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinMoving methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:15:19'!
cabinOnFloor: aSmallInteger as: anElevatorController 
	
	anElevatorController cabinOnFloorWhileCabinMoving.! !

!ElevatorCabinMoving methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:51:01'!
isMoving
	
	^ true! !

!ElevatorCabinMoving methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:50:53'!
isStopped
	
	^ false! !

!ElevatorCabinMoving methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:59:36'!
openCabinDoor: anElevatorCabinController 
	
	anElevatorCabinController openCabinDoorWhileMoving.! !


!classDefinition: #ElevatorCabinStopped category: #'Elevator-Ejercicio'!
ElevatorCabinState subclass: #ElevatorCabinStopped
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinStopped methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:33:21'!
cabinDoorOpened: anElevatorCabinController 
	
	anElevatorCabinController cabinDoorOpenedWhileStopped.! !

!ElevatorCabinStopped methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:09:43'!
isMoving
	
	^ false! !

!ElevatorCabinStopped methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:00:47'!
isStopped
	
	^ true! !

!ElevatorCabinStopped methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:44:40'!
openCabinDoor: anElevatorCabinController 
	
	anElevatorCabinController openCabinDoorWhileStopped.! !


!classDefinition: #ElevatorCabinWaiting category: #'Elevator-Ejercicio'!
ElevatorCabinState subclass: #ElevatorCabinWaiting
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'state cabinController cabinDoorController cabinFloorNumber floorsToGo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 16:42:57'!
cabinDoorClosed
	
	cabinController cabinDoorClosed: self.
	cabinDoorController cabinDoorClosed: self.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:32:20'!
cabinDoorOpened
	
	cabinController cabinDoorOpened: self.
	cabinDoorController cabinDoorOpened: self.
	state cabinDoorOpened: self.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:38:06'!
cabinDoorOpenedWhileWorking
	
	state _ ElevatorControllerIdle new! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:02:45'!
cabinFloorNumber
	^cabinFloorNumber! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:30:44'!
cabinOnFloor: aSmallInteger 
	
	state cabinOnFloor: aSmallInteger as: self.
	cabinController cabinOnFloor: aSmallInteger as:self.
	cabinDoorController cabinOnFloor: aSmallInteger as:self.
	cabinFloorNumber _ aSmallInteger .! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:12:28'!
cabinOnFloorAsWorking! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:13:21'!
goUpPushedFromFloor: aSmallInteger 
	
	state goUpPushedFromFloor: aSmallInteger on: self.
	cabinDoorController goUpPushedFromFloor: aSmallInteger on: self.
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:07:08'!
goUpPushedFromFloorWhileIdle
	
	state _ ElevatorControllerWorking new! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 20:41:08'!
initialize

	state _ ElevatorControllerIdle new.
	cabinController _ ElevatorCabinController new.
	cabinDoorController _ ElevatorCabinDoorController new.
	cabinFloorNumber _ 0.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:18:29'!
isCabinDoorClosed
	
	^ cabinDoorController isClosed! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:16:47'!
isCabinDoorClosing
	
	^ cabinDoorController isClosing! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:02:00'!
isCabinDoorOpened
	
	^ cabinDoorController isOpened! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:27:23'!
isCabinDoorOpening
	
	^ cabinDoorController isOpening.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:09:08'!
isCabinMoving
	
	^ cabinController isMoving! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 20:46:12'!
isCabinStopped
	^ cabinController isStopped.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 20:44:41'!
isIdle
	^ state isIdle! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:07:47'!
isWorking
	
	^ state isWorking! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:42:07'!
openCabinDoor
	
	state openCabinDoor: self.
	cabinController openCabinDoor: self.
	cabinDoorController openCabinDoor: self.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:43:43'!
openCabinDoorWhileIdle
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorController class' category: #'Elevator-Ejercicio'!
ElevatorController class
	instanceVariableNames: ''!

!ElevatorController class methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 20:36:44'!
new
	
	^ self basicNew initialize! !


!classDefinition: #ElevatorControllerState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorControllerState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:37:33'!
cabinDoorOpened: anElevatorController 
	
	anElevatorController cabinDoorOpenedWhileWorking.! !

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:11:40'!
cabinOnFloor: aSmallInteger as: anElevatorController 
	
	^ anElevatorController cabinOnFloorAsWorking.! !

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:03:42'!
goUpPushedFromFloor: aSmallInteger on: anElevatorController 
	
	^ self subclassResponsibility ! !

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 20:45:10'!
isIdle
	^self subclassResponsibility ! !

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:08:42'!
isWorking
	^self subclassResponsibility ! !

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:42:31'!
openCabinDoor: anElevatorController 
	
	anElevatorController openCabinDoorWhileIdle.! !


!classDefinition: #ElevatorControllerIdle category: #'Elevator-Ejercicio'!
ElevatorControllerState subclass: #ElevatorControllerIdle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerIdle methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:05:34'!
goUpPushedFromFloor: aSmallInteger on: anElevatorController 
	
	anElevatorController goUpPushedFromFloorWhileIdle.! !

!ElevatorControllerIdle methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 20:45:38'!
isIdle
	^true.! !

!ElevatorControllerIdle methodsFor: 'as yet unclassified' stamp: 'GF 10/5/2017 17:38:18'!
isWorking
	
	^ false! !


!classDefinition: #ElevatorControllerWorking category: #'Elevator-Ejercicio'!
ElevatorControllerState subclass: #ElevatorControllerWorking
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerWorking methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:07:24'!
isIdle
	
	^ false! !

!ElevatorControllerWorking methodsFor: 'as yet unclassified' stamp: 'GF 10/2/2017 21:08:01'!
isWorking
	
	^ true! !
