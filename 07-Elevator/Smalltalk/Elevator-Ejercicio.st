!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorEmergency class' category: #'Elevator-Ejercicio'!
ElevatorEmergency class
	instanceVariableNames: ''!

!ElevatorEmergency class methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 02:25:11'!
desynchronizedSensorDescription
	
	^ 'Sensor de cabina desincronizado'! !


!classDefinition: #CabinDoorState category: #'Elevator-Ejercicio'!
TestCase subclass: #CabinDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorState methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:26:41'!
isOpened
	^ self subclassResponsibility ! !


!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:03:13'!
close: anCabinDoorController
	
	^ self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:31:46'!
closed
	
	^ self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:37:01'!
closedOn: aCabinDoorController 
	
	^ self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:11:41'!
isClosed
	
	^ self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:10:33'!
isClosing
	
	^self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:08:50'!
isOpening
	
	^self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:41:12'!
open: aCabinDoorController 
	
	^ self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:47:56'!
openedOn: aCabinDoorController 
	
	^ self subclassResponsibility ! !


!classDefinition: #CabinDoorClosed category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorClosed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:39:34'!
isClosed
	
	^ true! !

!CabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:39:23'!
isClosing
	
	^ false! !

!CabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:38:58'!
isOpened
	
	^ false! !

!CabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:39:06'!
isOpening
	
	^ false! !

!CabinDoorClosed methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:41:31'!
open: aCabinDoorController 
	
	aCabinDoorController openClosedDoor! !


!classDefinition: #CabinDoorClosing category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorClosing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:38:08'!
closedOn: aCabinDoorController 
	
	aCabinDoorController finishClosing! !

!CabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:11:48'!
isClosed
	
	^ false! !

!CabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:10:42'!
isClosing
	
	^ true! !

!CabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:07:39'!
isOpened
	
	^ false! !

!CabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:09:00'!
isOpening
	
	^ false! !

!CabinDoorClosing methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:03:22'!
open: aCabinDoorController 
	
	aCabinDoorController openClosingDoor! !


!classDefinition: #CabinDoorOpened category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorOpened
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorOpened methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:27:03'!
isOpened
	^ true.! !


!CabinDoorOpened methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:03:36'!
close: aCabinDoorController
	
	aCabinDoorController closeOpenedDoor	! !

!CabinDoorOpened methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:49:43'!
isClosed

	^ false! !

!CabinDoorOpened methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:49:29'!
isClosing
	
	^ false! !

!CabinDoorOpened methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:49:20'!
isOpening
	
	^ false! !


!classDefinition: #CabinDoorOpening category: #'Elevator-Ejercicio'!
CabinDoorState subclass: #CabinDoorOpening
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:42:34'!
isClosed
	
	^ false! !

!CabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:42:22'!
isClosing
	
	^ false! !

!CabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:42:00'!
isOpened
	
	^ false! !

!CabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:42:09'!
isOpening
	
	^ true! !

!CabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:10:45'!
open: aCabinDoorController 
	
	aCabinDoorController openOpeningDoor! !

!CabinDoorOpening methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:48:35'!
openedOn: aCabinDoorController 
	
	aCabinDoorController finishOpening! !


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


!classDefinition: #CabinController category: #'Elevator-Ejercicio'!
Object subclass: #CabinController
	instanceVariableNames: 'state cabinDoorController floorNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinController methodsFor: 'initialization' stamp: 'GZ 10/11/2017 17:28:12'!
initializeOnFloor: aSmallInteger 
	
	state _ CabinStopped new.
	cabinDoorController _ CabinDoorController new.
	floorNumber _ aSmallInteger ! !


!CabinController methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:27:48'!
floorNumber
	^ floorNumber! !

!CabinController methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:25:24'!
isCabinDoorOpened
	^ cabinDoorController isOpened.! !

!CabinController methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 18:08:15'!
isCabinDoorOpening

	^ cabinDoorController isOpening! !

!CabinController methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:24:31'!
isStopped
	^ state isStopped.! !


!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:28:13'!
cabinDoorClosed
	
	state cabinDoorClosedOn: self ! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:30:03'!
cabinDoorClosedWhileStopped

	state _ CabinMoving new.
	cabinDoorController closed! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:46:19'!
cabinDoorOpened
	
	state cabinDoorOpenedOn: self! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:47:23'!
cabinDoorOpenedWhileStopped
	
	cabinDoorController opened! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:23:04'!
cabinDoorOpenedWhileWaitingForPeople
	
	cabinDoorController opened! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:02:13'!
closeCabinDoor
	
	cabinDoorController close! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:11:06'!
isCabinDoorClosed
	
	^ cabinDoorController isClosed! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:10:00'!
isCabinDoorClosing
	
	^ cabinDoorController isClosing! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:07:03'!
isMoving
	
	^ state isMoving ! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:12:16'!
isWaitingForPeople
	
	^ state isWaitingForPeople! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 22:57:27'!
openCabinDoor
	
	state openCabinDoorOf: self! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:10:03'!
openCabinDoorWhileMoving
	
	! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:02:41'!
openDoorWhileStopped

	cabinDoorController open! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 02:20:07'!
stopMovingOnFloor: aSmallInteger 
	
	state _ CabinStopped new.
	floorNumber _ aSmallInteger.! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:58:57'!
stopOnFloor: aSmallInteger 
	
	state stop: self onFloor: aSmallInteger ! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:21:00'!
waitForPeople
	
	state waitForPeopleIn: self ! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:33:09'!
waitForPeopleTimedOut
	
	state waitForPeopleTimedOutOn: self! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:42:31'!
waitForPeopleTimedOutWhileMoving
	! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:58:49'!
waitForPeopleTimedOutWhileStopped! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:34:47'!
waitForPeopleTimedOutWhileWaitingForPeople
	
	state _ CabinStopped new.
	cabinDoorController close! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 02:32:25'!
whileStoppedStopOnFloor: aSmallInteger 
	ElevatorEmergency signal: ElevatorEmergency desynchronizedSensorDescription ! !

!CabinController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:21:59'!
whileStoppedWaitForPeople
	
	state _ CabinWaitForPeople new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CabinController class' category: #'Elevator-Ejercicio'!
CabinController class
	instanceVariableNames: ''!

!CabinController class methodsFor: 'initialization' stamp: 'GZ 10/11/2017 17:19:27'!
initializeOnFloor: aSmallInteger 
	^ self new initializeOnFloor: aSmallInteger .! !


!classDefinition: #CabinDoorController category: #'Elevator-Ejercicio'!
Object subclass: #CabinDoorController
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinDoorController methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:25:41'!
isOpened
	^ state isOpened ! !


!CabinDoorController methodsFor: 'initialization' stamp: 'GZ 10/11/2017 17:26:14'!
initialize

	state _ CabinDoorOpened new! !


!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:02:56'!
close
	
	state close: self! !

!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:04:05'!
closeOpenedDoor
	
	state _ CabinDoorClosing new! !

!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:36:01'!
closed
	
	state closedOn: self! !

!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:38:43'!
finishClosing
	
	state _ CabinDoorClosed new! !

!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:48:56'!
finishOpening
	
	state _ CabinDoorOpened new.! !

!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:11:25'!
isClosed
	
	^ state isClosed ! !

!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:10:15'!
isClosing
	
	^ state isClosing ! !

!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:08:39'!
isOpening
	
	^ state isOpening ! !

!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:14:14'!
open
	
	state open: self! !

!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:41:49'!
openClosedDoor
	
	state _ CabinDoorOpening new! !

!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:05:49'!
openClosingDoor
	
	state _ CabinDoorOpening new! !

!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:11:06'!
openOpeningDoor! !

!CabinDoorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:47:41'!
opened
	
	state openedOn: self! !


!classDefinition: #CabinState category: #'Elevator-Ejercicio'!
Object subclass: #CabinState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinState methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:24:42'!
isStopped
	^self subclassResponsibility .! !


!CabinState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:28:28'!
cabinDoorClosedOn: aCabinController 
	
	^ self subclassResponsibility ! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:46:32'!
cabinDoorOpenedOn: aCabinController 
	
	^ self subclassResponsibility ! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:07:14'!
isMoving
	
	^ self subclassResponsibility ! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:12:29'!
isWaitingForPeople
	
	^ self subclassResponsibility ! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 22:59:49'!
openCabinDoorOf: aCabinController 
	
	^ self subclassResponsibility! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:12:20'!
stop: aCabinController onFloor: aSmallInteger 

	^self subclassResponsibility ! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:33:18'!
waitForPeopleTimedOutOn: aCabinController 
	
	^ self subclassResponsibility ! !


!classDefinition: #CabinMoving category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:34:38'!
isMoving
	
	^ true! !

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:34:27'!
isStopped
	
	^ false! !

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:09:47'!
openCabinDoorOf: aCabinController 
	
	aCabinController openCabinDoorWhileMoving! !

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:12:39'!
stop: aCabinController onFloor: aSmallInteger 
	
	aCabinController stopMovingOnFloor: aSmallInteger! !

!CabinMoving methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:42:20'!
waitForPeopleTimedOutOn: aCabinController 
	
	aCabinController waitForPeopleTimedOutWhileMoving! !


!classDefinition: #CabinStopped category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinStopped
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinStopped methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:24:51'!
isStopped
	^ true! !


!CabinStopped methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:29:02'!
cabinDoorClosedOn: aCabinController 

	aCabinController cabinDoorClosedWhileStopped! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:47:09'!
cabinDoorOpenedOn: aCabinController 
	
	aCabinController cabinDoorOpenedWhileStopped! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:07:23'!
isMoving
	
	^ false! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:12:41'!
isWaitingForPeople
	
	^ false! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:00:40'!
openCabinDoorOf: aCabinController 
	
	aCabinController openDoorWhileStopped! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 02:21:51'!
stop: aCabinController onFloor: aSmallInteger 

	aCabinController whileStoppedStopOnFloor: aSmallInteger ! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:21:39'!
waitForPeopleIn: aCabinController 
	
	aCabinController whileStoppedWaitForPeople! !

!CabinStopped methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:43:16'!
waitForPeopleTimedOutOn: aCabinController 
	
	aCabinController  waitForPeopleTimedOutWhileStopped! !


!classDefinition: #CabinWaitForPeople category: #'Elevator-Ejercicio'!
CabinState subclass: #CabinWaitForPeople
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!CabinWaitForPeople methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:22:42'!
cabinDoorOpenedOn: aCabinController 
	
	aCabinController cabinDoorOpenedWhileWaitingForPeople! !

!CabinWaitForPeople methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 02:05:18'!
isStopped
	^ false! !

!CabinWaitForPeople methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:23:18'!
isWaitingForPeople

	^ true! !

!CabinWaitForPeople methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:33:56'!
waitForPeopleTimedOutOn: aCabinController 
	
	aCabinController waitForPeopleTimedOutWhileWaitingForPeople! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'state cabinController floorsToGo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'initialization' stamp: 'GZ 10/11/2017 23:47:10'!
initialize
	state _ ElevatorIdle new.
	cabinController _ CabinController initializeOnFloor: 0.
	floorsToGo _ OrderedCollection new! !


!ElevatorController methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:27:32'!
cabinFloorNumber
	^ cabinController floorNumber.! !

!ElevatorController methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 18:09:42'!
isCabinDoorClosing

	^ cabinController isCabinDoorClosing ! !

!ElevatorController methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:25:06'!
isCabinDoorOpened
	^ cabinController isCabinDoorOpened .! !

!ElevatorController methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 18:06:51'!
isCabinMoving
	
	^ cabinController isMoving! !

!ElevatorController methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:22:52'!
isCabinStopped
	^ cabinController isStopped.! !

!ElevatorController methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:24:13'!
isIdle
	^ state isIdle.! !

!ElevatorController methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 18:04:40'!
isWorking
	
	^ state isWorking! !


!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:26:53'!
cabinDoorClosed
	
	state cabinDoorClosedOn: self! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:27:52'!
cabinDoorClosedWhileWorking

	cabinController  cabinDoorClosed! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:43:50'!
cabinDoorOpened
	
	state cabinDoorOpenedOn: self! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:20:19'!
cabinDoorOpenedWhileWorking
	
	( floorsToGo isEmpty) 
		ifTrue: [
			state _ ElevatorIdle new.
		]
		ifFalse: [
			cabinController waitForPeople		
		].
	
	cabinController cabinDoorOpened
! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:09:31'!
cabinOnFloor: aSmallInteger 

	state cabinOf: self onFloor: aSmallInteger ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:35:26'!
closeCabinDoor
	
	state closeCabinDoorOn: self! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:41:33'!
closeCabinDoorWhileIdle! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:37:40'!
closeCabinDoorWhileWorking

	cabinController waitForPeopleTimedOut ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:15:37'!
goUpPushedFromFloor: aSmallInteger 
	
	state goUpPushedFromFloor: aSmallInteger on: self! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:10:54'!
isCabinDoorClosed
	
	^ cabinController isCabinDoorClosed ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:07:55'!
isCabinDoorOpening
	
	^ cabinController isCabinDoorOpening ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:11:54'!
isCabinWaitingForPeople
	
	^ cabinController isWaitingForPeople! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:50:59'!
openCabinDoor

	state openCabinDoorOf: self! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:52:22'!
openCabinDoorWhileIddle! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 22:56:33'!
openCabinDoorWhileWorking
	
	cabinController openCabinDoor! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:29:59'!
waitForPeopleTimedOut
	
	state waitForPeopleTimedOutOn: self! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:32:44'!
waitForPeopleTimedOutWhileWorking
	
	cabinController waitForPeopleTimedOut ! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:48:53'!
whileIdleGoUpPushedFromFloor: aSmallInteger
	
	state _ ElevatorWorking new.
	floorsToGo add: aSmallInteger.
	cabinController closeCabinDoor! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 02:19:51'!
whileWorkingCabinOnFloor: aSmallInteger 

	cabinController stopOnFloor: aSmallInteger.
	
	(floorsToGo includes: aSmallInteger) 
		ifTrue: [
			floorsToGo remove: aSmallInteger.
			cabinController openCabinDoor 
	]! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:46:44'!
whileWorkingGoUpPushedFromFloor: aSmallInteger 
	
	floorsToGo add: aSmallInteger! !


!classDefinition: #ElevatorState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorState methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:23:52'!
isIdle
	^ self subclassResponsibility.! !

!ElevatorState methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 18:05:21'!
isWorking
	
	^ self subclassResponsibility ! !


!ElevatorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:27:16'!
cabinDoorClosedOn: anElevatorController 
	
	anElevatorController cabinDoorClosedWhileWorking! !

!ElevatorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:44:02'!
cabinDoorOpenedOn: anElevatorController 
	
	^ self subclassResponsibility ! !

!ElevatorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:09:46'!
cabinOf: anElevatorController onFloor: aSmallInteger 
	
	^self subclassResponsibility ! !

!ElevatorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:40:07'!
closeCabinDoorOn: anElevatorController 
	
	^ self subclassResponsibility ! !

!ElevatorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:27:59'!
goUpPushedFromFloor: aSmallInteger on: anElevatorController 
	
	^ anElevatorController whileWorkingGoUpPushedFromFloor: aSmallInteger.! !

!ElevatorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:51:27'!
openCabinDoorOf: anElevatorController 
	
	^ self subclassResponsibility .! !

!ElevatorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:30:14'!
waitForPeopleTimedOutOn: anElevatorController 
	
	^ self subclassResponsibility .! !


!classDefinition: #ElevatorIdle category: #'Elevator-Ejercicio'!
ElevatorState subclass: #ElevatorIdle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorIdle methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 17:23:30'!
isIdle
	^ true.! !


!ElevatorIdle methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:41:17'!
closeCabinDoorOn: anElevatorController 
	
	anElevatorController closeCabinDoorWhileIdle! !

!ElevatorIdle methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 23:19:28'!
goUpPushedFromFloor: aSmallInteger on: anElevatorController 
	
	anElevatorController whileIdleGoUpPushedFromFloor: aSmallInteger! !

!ElevatorIdle methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:49:09'!
isWorking
	
	^ false! !

!ElevatorIdle methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:52:11'!
openCabinDoorOf: anElevatorController 

	anElevatorController openCabinDoorWhileIddle! !


!classDefinition: #ElevatorWorking category: #'Elevator-Ejercicio'!
ElevatorState subclass: #ElevatorWorking
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorWorking methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 18:04:20'!
isIdle
	
	^ false! !

!ElevatorWorking methodsFor: 'inspecting' stamp: 'GZ 10/11/2017 18:05:34'!
isWorking
	
	^ true! !


!ElevatorWorking methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:44:20'!
cabinDoorOpenedOn: anElevatorController 
	
	anElevatorController cabinDoorOpenedWhileWorking! !

!ElevatorWorking methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:10:23'!
cabinOf: anElevatorController onFloor: aSmallInteger 
	
	anElevatorController whileWorkingCabinOnFloor: aSmallInteger ! !

!ElevatorWorking methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:40:53'!
closeCabinDoorOn: anElevatorController 
	
	anElevatorController closeCabinDoorWhileWorking ! !

!ElevatorWorking methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:53:06'!
openCabinDoorOf: anElevatorController 
	
	anElevatorController openCabinDoorWhileWorking! !

!ElevatorWorking methodsFor: 'as yet unclassified' stamp: 'GZ 10/12/2017 01:31:06'!
waitForPeopleTimedOutOn: anElevatorController 
	
	anElevatorController waitForPeopleTimedOutWhileWorking! !
