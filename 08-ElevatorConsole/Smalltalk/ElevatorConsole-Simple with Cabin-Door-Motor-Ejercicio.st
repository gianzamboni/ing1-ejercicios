!classDefinition: #ElevatorTest category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
TestCase subclass: #ElevatorTest
	instanceVariableNames: 'cabin door elevator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!ElevatorTest methodsFor: 'tests 3' stamp: 'HAW 10/3/2017 19:49:29'!
test09RequestToGoUpAreEnqueueWhenRequestedWhenCabinIsMoving

	elevator goUpPushedFromFloor:1.
	door closed.
	cabin onFloor: 1.
	elevator goUpPushedFromFloor:2.
	door opened.

	self assert: elevator isWorking.
	self assert: cabin isWaitingForPeople.
	self assert: door isOpened.

	self assert: door isMotorStopped.
	self assert: cabin isMotorStopped
! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HAW 10/3/2017 19:49:33'!
test10CabinDoorStartClosingAfterWaitingForPeople

	elevator goUpPushedFromFloor:1.
	door closed.
	cabin onFloor: 1.
	elevator goUpPushedFromFloor:2.
	door opened.
	cabin waitForPeopleTimedOut.

	self assert: elevator isWorking.
	self assert: cabin isStopped.
	self assert: door isClosing.

	self assert: door isMotorMovingClockwise.
	self assert: cabin isMotorStopped
! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HAW 10/4/2017 10:17:12'!
test11StopsWaitingForPeopleIfCloseDoorIsPressed

	elevator goUpPushedFromFloor:1.
	door closed.
	cabin onFloor: 1.
	elevator goUpPushedFromFloor:2.
	door opened.

	self assert: elevator isWorking.
	self assert: cabin isWaitingForPeople.
	self assert: door isOpened.

	door close.

	self assert: elevator isWorking.
	self assert: cabin isStopped.
	self assert: door isClosing.

	self assert: door isMotorMovingClockwise.
	self assert: cabin isMotorStopped

! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HAW 10/4/2017 10:17:18'!
test12CloseDoorDoesNothingIfIdle

	door close.

	self assert: elevator isIdle.
	self assert: cabin isStopped.
	self assert: door isOpened.

	self assert: door isMotorStopped.
	self assert: cabin isMotorStopped
! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HAW 10/4/2017 10:17:23'!
test13CloseDoorDoesNothingWhenCabinIsMoving

	elevator goUpPushedFromFloor:1.
	door closed.

	self assert: elevator isWorking.
	self assert: cabin isMoving.
	self assert: door isClosed.

	door close.

	self assert: elevator isWorking.
	self assert: cabin isMoving.
	self assert: door isClosed.

	self assert: door isMotorStopped.
	self assert: cabin isMotorMovingClockwise! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HAW 10/4/2017 10:20:58'!
test14CloseDoorDoesNothingWhenOpeningTheDoorToWaitForPeople

	elevator goUpPushedFromFloor:1.
	door closed.
	cabin onFloor: 1.

	self assert: elevator isWorking.
	self assert: cabin isStopped.
	self assert: door isOpening.

	door close.

	self assert: elevator isWorking.
	self assert: cabin isStopped.
	self assert: door isOpening.

	self assert: door isMotorMovingCounterClockwise.
	self assert: cabin isMotorStopped
	! !


!ElevatorTest methodsFor: 'tests 4' stamp: 'HAW 10/4/2017 10:12:01'!
test15ElevatorHasToEnterEmergencyIfStoppedAndOtherFloorSensorTurnsOn

	elevator goUpPushedFromFloor:1.
	door closed.
	cabin onFloor: 1.

	self
		should: [ cabin onFloor: 0 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = Cabin sensorDesincronizedErrorMessage ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HAW 10/4/2017 10:12:08'!
test16ElevatorHasToEnterEmergencyIfFalling

	elevator goUpPushedFromFloor:2.
	door closed.
	cabin onFloor: 1.

	self
		should: [ cabin onFloor: 0 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = Cabin sensorDesincronizedErrorMessage ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HAW 10/4/2017 10:12:15'!
test17ElevatorHasToEnterEmergencyIfJumpsFloors

	elevator goUpPushedFromFloor:3.
	door closed.

	self
		should: [ cabin onFloor:  3 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = Cabin sensorDesincronizedErrorMessage ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HAW 10/4/2017 10:12:30'!
test18ElevatorHasToEnterEmergencyIfDoorClosesAutomatically

	self
		should: [ door closed ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = CabinDoor sensorDesincronizedErrorMessage ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HAW 10/4/2017 10:12:41'!
test19ElevatorHasToEnterEmergencyIfDoorClosedSensorTurnsOnWhenClosed

	elevator goUpPushedFromFloor:1.
	door closed.

	self
		should: [ door closed ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = CabinDoor sensorDesincronizedErrorMessage ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HAW 10/4/2017 10:12:56'!
test20ElevatorHasToEnterEmergencyIfDoorClosesWhenOpening

	elevator goUpPushedFromFloor:1.
	door closed.
	cabin onFloor: 1.

	self
		should: [ door closed ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = CabinDoor sensorDesincronizedErrorMessage ]! !


!ElevatorTest methodsFor: 'tests 2' stamp: 'HAW 10/4/2017 10:15:57'!
test06DoorKeepsOpenedWhenOpeningIsRequested

	self assert: door isOpened.

	door open.

	self assert: door isOpened.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HAW 10/4/2017 10:16:09'!
test07DoorMustBeOpenedWhenCabinIsStoppedAndClosingDoors

	elevator goUpPushedFromFloor: 1.

	self assert: elevator isWorking.
	self assert: cabin isStopped.
	self assert: door isClosing.

	door open.

	self assert: elevator isWorking.
	self assert: cabin isStopped.
	self assert: door isOpening.

	self assert: door isMotorMovingCounterClockwise.
	self assert: cabin isMotorStopped

! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HAW 10/4/2017 10:16:04'!
test08CanNotOpenDoorWhenCabinIsMoving

	elevator goUpPushedFromFloor:1.
	door closed.

	self assert: elevator isWorking.
	self assert: cabin isMoving.
	self assert: door isClosed.

	door open.

	self assert: elevator isWorking.
	self assert: cabin isMoving.
	self assert: door isClosed.

	self assert: door isMotorStopped.
	self assert: cabin isMotorMovingClockwise
	! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HAW 10/4/2017 10:15:49'!
test09DoorKeepsOpeneingWhenItIsOpeneing

	elevator goUpPushedFromFloor:1.
	door closed.
	cabin onFloor: 1.

	self assert: elevator isWorking.
	self assert: cabin isStopped.
	self assert: door isOpening.

	door open.
	
	self assert: elevator isWorking.
	self assert: cabin isStopped.
	self assert: door isOpening.

	self assert: door isMotorMovingCounterClockwise.
	self assert: cabin isMotorStopped
! !


!ElevatorTest methodsFor: 'tests 5' stamp: 'HAW 10/4/2017 10:13:05'!
test21CabinHasToStopOnTheFloorsOnItsWay

	elevator goUpPushedFromFloor:1.
	door closed.
	elevator goUpPushedFromFloor:2.
	cabin onFloor: 1.

	self assert: elevator isWorking.
	self assert: cabin isStopped.
	self assert: door isOpening.

	self assert: cabin currentFloorNumber equals: 1.

	self assert: door isMotorMovingCounterClockwise.
	self assert: cabin isMotorStopped
! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HAW 10/4/2017 10:13:09'!
test22ElevatorCompletesAllTheRequests

	elevator goUpPushedFromFloor:1.
	door closed.
	elevator goUpPushedFromFloor:2.
	cabin onFloor: 1.
	door opened.
	cabin waitForPeopleTimedOut.
	door closed.
	cabin onFloor: 2.

	self assert: elevator isWorking.
	self assert: cabin isStopped.
	self assert: door isOpening.

	self assert: cabin currentFloorNumber equals: 2.

	self assert: door isMotorMovingCounterClockwise.
	self assert: cabin isMotorStopped
! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HAW 10/4/2017 10:13:15'!
test23CabinHasToStopOnFloorsOnItsWayNoMatterHowTheyWellCalled

	elevator goUpPushedFromFloor:2.
	door closed.
	elevator goUpPushedFromFloor:1.
	cabin onFloor: 1.

	self assert: elevator isWorking.
	self assert: cabin isStopped.
	self assert: door isOpening.

	self assert: cabin currentFloorNumber equals: 1.

	self assert: door isMotorMovingCounterClockwise.
	self assert: cabin isMotorStopped
! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HAW 10/4/2017 10:13:19'!
test24CabinHasToStopAndWaitForPeopleOnFloorsOnItsWayNoMatterHowTheyWellCalled

	elevator goUpPushedFromFloor:2.
	door closed.
	elevator goUpPushedFromFloor:1.
	cabin onFloor: 1.
	door opened.
	cabin waitForPeopleTimedOut.

	self assert: elevator isWorking.
	self assert: cabin isStopped.
	self assert: door isClosing.

	self assert: cabin currentFloorNumber equals: 1.

	self assert: door isMotorMovingClockwise.
	self assert: cabin isMotorStopped
! !


!ElevatorTest methodsFor: 'tests 1' stamp: 'HAW 10/4/2017 09:59:00'!
test01ElevatorStartsIdleWithDoorOpenOnFloorZero

	self assert: elevator isIdle.
	self assert: cabin isStopped.
	self assert: door isOpened.
	self assert: cabin currentFloorNumber = 0
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HAW 10/4/2017 10:00:49'!
test02CabinDoorStartsClosingWhenElevatorGetsCalled

	elevator goUpPushedFromFloor: 1.

	self deny: elevator isIdle.
	self assert: elevator isWorking.

	self assert: cabin isStopped.
	self deny: cabin isMoving.

	self deny: door isOpened.
	self deny: door isOpening.
	self assert: door isClosing.
	self deny: door isClosed.

	self assert: door isMotorMovingClockwise.
	self assert: cabin isMotorStopped
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HAW 10/4/2017 10:01:22'!
test03CabinStartsMovingWhenDoorGetsClosed

	elevator goUpPushedFromFloor:1.
	door closed.

	self deny: elevator isIdle.
	self assert: elevator isWorking.

	self deny: cabin isStopped.
	self assert: cabin isMoving.

	self deny: door isOpened.
	self deny: door isOpening.
	self deny: door isClosing.
	self assert: door isClosed.

	self assert: door isMotorStopped.
	self assert: cabin isMotorMovingClockwise.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HAW 10/4/2017 10:05:03'!
test04CabinStopsAndStartsOpeningDoorWhenGetsToDestination

	elevator goUpPushedFromFloor: 1.
	door closed.
	cabin onFloor:  1.

	self deny: elevator isIdle.
	self assert: elevator isWorking.

	self assert: cabin isStopped.
	self deny: cabin isMoving.

	self deny: door isOpened.
	self assert: door isOpening.
	self deny: door isClosing.
	self deny: door isClosed.

	self assert: cabin currentFloorNumber = 1.

	self assert: door isMotorMovingCounterClockwise.
	self assert: cabin isMotorStopped.

! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HAW 10/4/2017 10:05:16'!
test05ElevatorGetsIdleWhenDoorGetOpened

	elevator goUpPushedFromFloor: 1.
	door closed.
	cabin onFloor:  1.
	door opened.

	self assert: elevator isIdle.
	self deny: elevator isWorking.

	self assert: cabin isStopped.
	self deny: cabin isMoving.

	self assert: door isOpened.
	self deny: door isOpening.
	self deny: door isClosing.
	self deny: door isClosed.

	self assert: cabin currentFloorNumber = 1.

	self assert: door isMotorStopped.
	self assert: cabin isMotorStopped.
! !


!ElevatorTest methodsFor: 'setup' stamp: 'HAW 10/4/2017 09:59:22'!
setUp

	elevator := Elevator new.
	cabin := elevator cabin.
	door := cabin door.! !


!classDefinition: #ElevatorViewTest category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
TestCase subclass: #ElevatorViewTest
	instanceVariableNames: 'elevator door cabin'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!ElevatorViewTest methodsFor: 'testing' stamp: 'HAW 10/4/2017 12:44:01'!
test01ElevatorControllerConsoleTracksDoorClosingState

	| elevatorConsole readStream |
	
	elevatorConsole := ElevatorConsole of: elevator.
		
	elevator goUpPushedFromFloor: 1.
				
	readStream := elevatorConsole consoleReadStream.

	self assert: 'Puerta Cerrandose' = readStream nextLine.
	self assert: readStream atEnd! !

!ElevatorViewTest methodsFor: 'testing' stamp: 'HAW 10/4/2017 12:43:51'!
test02ElevatorControllerConsoleTracksCabinState

	| elevatorConsole readStream |
	
	elevatorConsole := ElevatorConsole of: elevator.
		
	elevator goUpPushedFromFloor: 1.
	door closed.
			
	readStream := elevatorConsole consoleReadStream.

	self assert: 'Puerta Cerrandose' = readStream nextLine.
	self assert: 'Puerta Cerrada' = readStream nextLine.
	self assert: 'Cabina Moviendose' = readStream nextLine.
	self assert: readStream atEnd
! !

!ElevatorViewTest methodsFor: 'testing' stamp: 'HAW 10/4/2017 12:44:46'!
test03ElevatorControllerConsoleTracksCabinAndDoorStateChanges

	| elevatorConsole readStream |
	
	elevatorConsole := ElevatorConsole of: elevator.
		
	elevator goUpPushedFromFloor: 1.
	door closed.
	cabin onFloor: 1.  
					
	readStream := elevatorConsole consoleReadStream.

	self assert: 'Puerta Cerrandose' = readStream nextLine.
	self assert: 'Puerta Cerrada' = readStream nextLine.
	self assert: 'Cabina Moviendose' = readStream nextLine.
	self assert: 'Cabina Detenida' = readStream nextLine.
	self assert: 'Puerta Abriendose' = readStream nextLine.
	self assert: readStream atEnd
! !

!ElevatorViewTest methodsFor: 'testing' stamp: 'HAW 10/4/2017 12:45:42'!
test04ElevatorControllerCanHaveMoreThanOneView
 
	| elevatorConsole readStream elevatorStatusView |
	
	elevatorConsole := ElevatorConsole of: elevator.
	elevatorStatusView := ElevatorStatusView of: elevator.
		
	elevator goUpPushedFromFloor: 1.
	door closed.
	cabin onFloor: 1.  
		
	readStream := elevatorConsole consoleReadStream.

	self assert: 'Puerta Cerrandose' = readStream nextLine.
	self assert: 'Puerta Cerrada' = readStream nextLine.
	self assert: 'Cabina Moviendose' = readStream nextLine.
	self assert: 'Cabina Detenida' = readStream nextLine.
	self assert: 'Puerta Abriendose' = readStream nextLine.
	self assert: readStream atEnd.

	self assert: 'Stopped' = elevatorStatusView cabinFieldModel.
	self assert: 'Opening' = elevatorStatusView cabinDoorFieldModel! !


!ElevatorViewTest methodsFor: 'setup' stamp: 'HAW 10/4/2017 13:50:13'!
setUp

	elevator := Elevator new.
	cabin := elevator cabin.
	door := cabin door.! !


!classDefinition: #Cabin category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
Object subclass: #Cabin
	instanceVariableNames: 'elevator state door motor currentFloorNumber suscriptors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!Cabin methodsFor: 'initialization' stamp: 'GF 10/12/2017 19:41:08'!
initializeOf: anElevator

	elevator := anElevator.
	door := CabinDoor of: self.
	motor := Motor new.
	currentFloorNumber := 0.
	state := CabinStoppedState for: self.
	suscriptors := Set new.! !


!Cabin methodsFor: 'actions' stamp: 'HAW 10/3/2017 16:48:24'!
stop
	
	motor stop.
	self makeStopped! !

!Cabin methodsFor: 'actions' stamp: 'HAW 10/3/2017 19:37:43'!
waitForPeople
	
	"TODO: Faltan tests, por ejemplo para asertar que solo lo puede hacer si esta parada - Hernan"
	self makeWaitingForPeople
! !


!Cabin methodsFor: 'state change' stamp: 'GF 10/12/2017 20:17:33'!
makeMoving
	state _ CabinMovingState for: self.
	self updateSuscriptors: [ :suscriptor |
		suscriptor visitCabinMoving: state ].! !

!Cabin methodsFor: 'state change' stamp: 'GF 10/12/2017 20:23:18'!
makeStopped
	
	state := CabinStoppedState for: self.
	self updateSuscriptors: [ :suscriptor | suscriptor visitCabinStopped: state ].! !

!Cabin methodsFor: 'state change' stamp: 'HAW 10/4/2017 14:15:37'!
makeWaitingForPeople
	
	state := CabinWaitingForPeopleState for: self! !


!Cabin methodsFor: 'sensor activation' stamp: 'HAW 10/3/2017 16:47:02'!
onFloor: aFloorNumber

	self assertIsMovingCorrectly: aFloorNumber.
		
	currentFloorNumber := aFloorNumber.
	elevator hasToStopOnCurrentFloor ifTrue: [self reachedFloorToStop ]
! !

!Cabin methodsFor: 'sensor activation' stamp: 'HAW 10/3/2017 19:41:00'!
waitForPeopleTimedOut
	
	self startClosingDoor.
	self makeStopped.! !


!Cabin methodsFor: 'floor' stamp: 'HAW 10/3/2017 16:01:27'!
currentFloorNumber

	^currentFloorNumber! !

!Cabin methodsFor: 'floor' stamp: 'HAW 10/4/2017 10:30:50'!
reachedFloorToStop
	
	elevator reachedFloorToStop.
	self stop.
	door startOpening! !


!Cabin methodsFor: 'testing' stamp: 'HAW 10/4/2017 10:09:51'!
hasToWaitForPeople
	
	^elevator hasFloorsToGo ! !

!Cabin methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:19:46'!
isMoving
	
	^state isMoving! !

!Cabin methodsFor: 'testing' stamp: 'HAW 10/3/2017 15:49:56'!
isStopped

	^state isStopped! !

!Cabin methodsFor: 'testing' stamp: 'HAW 10/3/2017 19:38:52'!
isWaitingForPeople
	
	^state isWaitingForPeople ! !


!Cabin methodsFor: 'assertions' stamp: 'HAW 10/3/2017 20:02:57'!
assertIsMovingCorrectly: aFloorNumber

	"Esta implementacion es muy sencilla y asume que se esta yendo para arriba siempre"
	currentFloorNumber+1 ~=aFloorNumber ifTrue: [ self signalSensorDesincronized ]! !


!Cabin methodsFor: 'exceptions' stamp: 'HAW 10/3/2017 20:03:29'!
sensorDesincronizedErrorMessage
	
	^self class sensorDesincronizedErrorMessage! !

!Cabin methodsFor: 'exceptions' stamp: 'HAW 10/3/2017 20:03:20'!
signalSensorDesincronized
	
	self error: self sensorDesincronizedErrorMessage! !


!Cabin methodsFor: 'door - closing' stamp: 'HAW 10/3/2017 21:24:54'!
closeDoor
	
	^state closeDoor! !

!Cabin methodsFor: 'door - closing' stamp: 'HAW 10/3/2017 19:52:04'!
closeDoorWhenMoving
	
	"La puerta ya esta cerrada, no hay que hacer nada con este pedido - Hernan"! !

!Cabin methodsFor: 'door - closing' stamp: 'HAW 10/3/2017 19:57:34'!
closeDoorWhenStopped
	
	"Si estoy parado no me pueden cerrar la puerta - Hernan"! !

!Cabin methodsFor: 'door - closing' stamp: 'HAW 10/4/2017 10:24:05'!
closeDoorWhenWaitingForPeople
	
	door startClosing.
	self makeStopped! !

!Cabin methodsFor: 'door - closing' stamp: 'HAW 10/3/2017 16:13:11'!
startClosingDoor
	
	door startClosing! !


!Cabin methodsFor: 'door - sensor activation' stamp: 'HAW 10/4/2017 10:04:32'!
doorClosed
	
	"Esto sirve solo porque siempre se esta yendo para arriba :-)"
	motor moveClockwise.
	self makeMoving.! !

!Cabin methodsFor: 'door - sensor activation' stamp: 'HAW 10/4/2017 10:09:29'!
doorOpened
	
	self hasToWaitForPeople ifTrue: [ self waitForPeople ] ifFalse: [ elevator jobDone]! !


!Cabin methodsFor: 'motor - testing' stamp: 'HAW 10/3/2017 16:41:45'!
isMotorMovingClockwise
	
	^motor isMovingClockwise ! !

!Cabin methodsFor: 'motor - testing' stamp: 'HAW 10/3/2017 16:26:17'!
isMotorStopped
	
	^motor isStopped! !


!Cabin methodsFor: 'door' stamp: 'HAW 10/4/2017 09:59:53'!
door

	^door! !


!Cabin methodsFor: 'as yet unclassified' stamp: 'GF 10/12/2017 19:40:08'!
subscribe: anElevatorConsole 
	
	suscriptors add: anElevatorConsole.
	door subscribe: anElevatorConsole.! !

!Cabin methodsFor: 'as yet unclassified' stamp: 'GF 10/12/2017 20:18:28'!
updateSuscriptors: aBlock
	
	suscriptors do: aBlock.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cabin class' category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
Cabin class
	instanceVariableNames: ''!

!Cabin class methodsFor: 'instance creation' stamp: 'HAW 10/3/2017 15:49:25'!
of: anElevator

	^self new initializeOf: anElevator! !


!Cabin class methodsFor: 'exceptions' stamp: 'HAW 10/3/2017 20:00:48'!
sensorDesincronizedErrorMessage
	
	^'Sensor de cabina desincronizado'! !


!classDefinition: #CabinDoor category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
Object subclass: #CabinDoor
	instanceVariableNames: 'cabin state motor suscriptors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!CabinDoor methodsFor: 'initialization' stamp: 'GF 10/12/2017 19:41:23'!
initializeOf: aCabin

	cabin := aCabin.
	motor := Motor new.
	state :=CabinDoorOpenedState for: self.
	suscriptors := Set new.! !


!CabinDoor methodsFor: 'actions' stamp: 'HAW 10/4/2017 10:21:35'!
close

	cabin closeDoor.
	
	! !

!CabinDoor methodsFor: 'actions' stamp: 'HAW 10/3/2017 17:00:25'!
open
	
	state open! !

!CabinDoor methodsFor: 'actions' stamp: 'HAW 10/4/2017 10:28:32'!
startClosing
	
	motor moveClockwise.
	self makeClosing	! !

!CabinDoor methodsFor: 'actions' stamp: 'HAW 10/4/2017 10:28:35'!
startOpening
	
	motor moveCounterClockwise.
	self makeOpening	! !


!CabinDoor methodsFor: 'actions - private' stamp: 'HAW 10/3/2017 17:04:32'!
openWhenClosed
	
	"Cuando la puerta esta cerrada no se puede abrir - Hernan"! !

!CabinDoor methodsFor: 'actions - private' stamp: 'HAW 10/3/2017 17:03:09'!
openWhenClosing
	
	motor stop.
	self startOpening
	! !

!CabinDoor methodsFor: 'actions - private' stamp: 'HAW 10/3/2017 17:01:19'!
openWhenOpened
	
	"Ya estoy abierta, no hago nada - Hernan"! !

!CabinDoor methodsFor: 'actions - private' stamp: 'HAW 10/3/2017 17:06:04'!
openWhenOpening
	
	"No hago nada porque ya me estoy abriendo - Hernan"! !


!CabinDoor methodsFor: 'sensor activation' stamp: 'HAW 10/3/2017 16:36:05'!
closed
	
	state closed! !

!CabinDoor methodsFor: 'sensor activation' stamp: 'HAW 10/4/2017 10:06:46'!
opened
	
	"TODO: Faltan tests para reaccionar distinto dependiendo del estado - Hernan"
	
	motor stop.
	self makeOpened.
	
	cabin doorOpened ! !


!CabinDoor methodsFor: 'sensor activation - private' stamp: 'HAW 10/3/2017 20:09:21'!
closedWhenClosed
	
	self signalSensorDesincronized ! !

!CabinDoor methodsFor: 'sensor activation - private' stamp: 'HAW 10/4/2017 10:04:22'!
closedWhenClosing
	
	motor stop.
	self makeClosed.
	
	cabin doorClosed.! !

!CabinDoor methodsFor: 'sensor activation - private' stamp: 'HAW 10/3/2017 20:08:10'!
closedWhenOpened
	
	self signalSensorDesincronized! !

!CabinDoor methodsFor: 'sensor activation - private' stamp: 'HAW 10/3/2017 20:10:00'!
closedWhenOpening
	
	self signalSensorDesincronized ! !


!CabinDoor methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:22:23'!
isClosed
	
	^state isClosed! !

!CabinDoor methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:21:40'!
isClosing
	
	^state isClosing! !

!CabinDoor methodsFor: 'testing' stamp: 'HAW 10/3/2017 15:58:57'!
isOpened

	^state isOpened ! !

!CabinDoor methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:20:56'!
isOpening
	
	^state isOpening ! !


!CabinDoor methodsFor: 'motor - testing' stamp: 'HAW 10/3/2017 16:25:35'!
isMotorMovingClockwise
	
	^motor isMovingClockwise! !

!CabinDoor methodsFor: 'motor - testing' stamp: 'HAW 10/3/2017 16:52:13'!
isMotorMovingCounterClockwise
	
	^motor isMovingCounterClockwise! !

!CabinDoor methodsFor: 'motor - testing' stamp: 'HAW 10/3/2017 16:41:21'!
isMotorStopped
	
	^motor isStopped! !


!CabinDoor methodsFor: 'state change' stamp: 'GF 10/12/2017 20:17:33'!
makeClosed
	state _ CabinDoorClosedState for: self.
	self updateSuscriptors: [ :suscriptor |
		suscriptor visitCabinDoorClosed: state ].! !

!CabinDoor methodsFor: 'state change' stamp: 'GF 10/12/2017 20:17:33'!
makeClosing
	state _ CabinDoorClosingState for: self.
	self updateSuscriptors: [ :suscriptor |
		suscriptor visitCabinDoorClosing: state ].! !

!CabinDoor methodsFor: 'state change' stamp: 'HAW 10/4/2017 14:15:02'!
makeOpened
	
	state := CabinDoorOpenedState for: self! !

!CabinDoor methodsFor: 'state change' stamp: 'GF 10/12/2017 20:23:34'!
makeOpening
	
	state := CabinDoorOpeningState for: self.
	self updateSuscriptors: [ :suscriptor | suscriptor visitCabinDoorOpening: state ].! !


!CabinDoor methodsFor: 'exceptions' stamp: 'HAW 10/3/2017 20:08:30'!
sensorDesincronizedErrorMessage
	
	^self class sensorDesincronizedErrorMessage ! !

!CabinDoor methodsFor: 'exceptions' stamp: 'HAW 10/3/2017 20:08:18'!
signalSensorDesincronized
	
	self error: self sensorDesincronizedErrorMessage! !


!CabinDoor methodsFor: 'as yet unclassified' stamp: 'GF 10/12/2017 20:01:08'!
self
	
	! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'GF 10/12/2017 19:41:40'!
subscribe: anElevatorConsole 
	
	suscriptors add: anElevatorConsole ! !

!CabinDoor methodsFor: 'as yet unclassified' stamp: 'GF 10/12/2017 20:17:33'!
updateSuscriptors: aBlock
	suscriptors do: aBlock.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CabinDoor class' category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
CabinDoor class
	instanceVariableNames: ''!

!CabinDoor class methodsFor: 'instance creation' stamp: 'HAW 10/3/2017 15:56:58'!
of: aCabin

	^self new initializeOf: aCabin ! !


!CabinDoor class methodsFor: 'exceptions' stamp: 'HAW 10/3/2017 20:08:48'!
sensorDesincronizedErrorMessage
	
	^'Sensor de puerta desincronizado'! !


!classDefinition: #CabinDoorState category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
Object subclass: #CabinDoorState
	instanceVariableNames: 'door'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!


!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:03:13'!
close: anCabinDoorController
	
	^ self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:37:01'!
closedOn: aCabinDoorController 
	
	^ self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:41:12'!
open: aCabinDoorController 
	
	^ self subclassResponsibility ! !

!CabinDoorState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:47:56'!
openedOn: aCabinDoorController 
	
	^ self subclassResponsibility ! !


!CabinDoorState methodsFor: 'initialization' stamp: 'HAW 10/3/2017 16:42:05'!
initializeFor: aCabinDoor

	door := aCabinDoor ! !


!CabinDoorState methodsFor: 'sensor activation' stamp: 'HAW 10/3/2017 20:25:19'!
closed

	self subclassResponsibility ! !


!CabinDoorState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:23:58'!
isClosed

	self subclassResponsibility ! !

!CabinDoorState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:24:07'!
isClosing

	self subclassResponsibility ! !

!CabinDoorState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:24:03'!
isOpened

	self subclassResponsibility ! !

!CabinDoorState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:24:10'!
isOpening

	self subclassResponsibility ! !


!CabinDoorState methodsFor: 'actions' stamp: 'HAW 10/3/2017 20:25:40'!
open

	self subclassResponsibility ! !


!CabinDoorState methodsFor: 'visitor' stamp: 'HAW 10/4/2017 14:17:24'!
accept: aVisitor

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CabinDoorState class' category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
CabinDoorState class
	instanceVariableNames: ''!

!CabinDoorState class methodsFor: 'instance creation' stamp: 'HAW 10/3/2017 15:57:56'!
for: aCabinDoor

	^self new initializeFor: aCabinDoor ! !


!classDefinition: #CabinDoorClosedState category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
CabinDoorState subclass: #CabinDoorClosedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!CabinDoorClosedState methodsFor: 'sensor activation' stamp: 'HAW 10/3/2017 20:26:47'!
closed
	
	^door closedWhenClosed! !


!CabinDoorClosedState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:39:59'!
isClosed
	
	^true! !

!CabinDoorClosedState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:39:46'!
isClosing
	
	^false! !

!CabinDoorClosedState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:39:22'!
isOpened
	
	^false! !

!CabinDoorClosedState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:39:33'!
isOpening
	
	^false! !


!CabinDoorClosedState methodsFor: 'actions' stamp: 'HAW 10/3/2017 20:26:58'!
open
	
	^door openWhenClosed! !


!CabinDoorClosedState methodsFor: 'visitor' stamp: 'HAW 10/4/2017 14:06:38'!
accept: aVisitor

	aVisitor visitCabinDoorClosed: self! !


!classDefinition: #CabinDoorClosingState category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
CabinDoorState subclass: #CabinDoorClosingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!CabinDoorClosingState methodsFor: 'sensor activation' stamp: 'HAW 10/3/2017 20:27:13'!
closed
	
	^door closedWhenClosing! !


!CabinDoorClosingState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:24:49'!
isClosed
	
	^false! !

!CabinDoorClosingState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:21:52'!
isClosing
	
	^true! !

!CabinDoorClosingState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:20:10'!
isOpened
	
	^false! !

!CabinDoorClosingState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:21:07'!
isOpening
	
	^false! !


!CabinDoorClosingState methodsFor: 'actions' stamp: 'HAW 10/3/2017 20:27:25'!
open
	
	^door openWhenClosing! !


!CabinDoorClosingState methodsFor: 'visitor' stamp: 'HAW 10/4/2017 14:02:34'!
accept: aVisitor

	aVisitor visitCabinDoorClosing: self! !


!classDefinition: #CabinDoorOpenedState category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
CabinDoorState subclass: #CabinDoorOpenedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!CabinDoorOpenedState methodsFor: 'sensor activation' stamp: 'HAW 10/3/2017 20:27:34'!
closed
	
	^door closedWhenOpened! !


!CabinDoorOpenedState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:56:42'!
isClosed
	
	^false! !

!CabinDoorOpenedState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:56:34'!
isClosing
	
	^false! !

!CabinDoorOpenedState methodsFor: 'testing' stamp: 'HAW 10/3/2017 15:59:04'!
isOpened

	^true! !

!CabinDoorOpenedState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:56:27'!
isOpening
	
	^false! !


!CabinDoorOpenedState methodsFor: 'actions' stamp: 'HAW 10/3/2017 20:27:44'!
open
	
	^door openWhenOpened! !


!CabinDoorOpenedState methodsFor: 'visitor' stamp: 'HAW 10/4/2017 14:17:52'!
accept: aVisitor

	aVisitor visitCabinDoorOpened: self! !


!classDefinition: #CabinDoorOpeningState category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
CabinDoorState subclass: #CabinDoorOpeningState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!CabinDoorOpeningState methodsFor: 'sensor activation' stamp: 'HAW 10/3/2017 20:27:52'!
closed
	
	^door closedWhenOpening! !


!CabinDoorOpeningState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:51:22'!
isClosed
	
	^false! !

!CabinDoorOpeningState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:51:12'!
isClosing
	
	^false! !

!CabinDoorOpeningState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:50:53'!
isOpened
	
	^false! !

!CabinDoorOpeningState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:51:05'!
isOpening
	
	^true! !


!CabinDoorOpeningState methodsFor: 'actions' stamp: 'HAW 10/3/2017 20:27:59'!
open
	
	^door openWhenOpening! !


!CabinDoorOpeningState methodsFor: 'visitor' stamp: 'HAW 10/4/2017 14:08:20'!
accept: aVisitor

	aVisitor visitCabinDoorOpening: self! !


!classDefinition: #CabinState category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
Object subclass: #CabinState
	instanceVariableNames: 'cabin'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!


!CabinState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 18:28:28'!
cabinDoorClosedOn: aCabinController 
	
	^ self subclassResponsibility ! !

!CabinState methodsFor: 'as yet unclassified' stamp: 'GZ 10/11/2017 19:46:32'!
cabinDoorOpenedOn: aCabinController 
	
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


!CabinState methodsFor: 'initialization' stamp: 'HAW 10/3/2017 15:53:27'!
initializeFor: aCabin

	cabin := aCabin ! !


!CabinState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:28:43'!
isMoving

	self subclassResponsibility 
	! !

!CabinState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:28:51'!
isStopped

	self subclassResponsibility 
	! !

!CabinState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:28:59'!
isWaitingForPeople

	self subclassResponsibility 
	! !


!CabinState methodsFor: 'actions' stamp: 'HAW 10/3/2017 20:29:18'!
closeDoor

	self subclassResponsibility ! !


!CabinState methodsFor: 'visitor' stamp: 'HAW 10/4/2017 14:19:06'!
accept: aVisitor

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CabinState class' category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
CabinState class
	instanceVariableNames: ''!

!CabinState class methodsFor: 'instance creation' stamp: 'HAW 10/3/2017 15:52:58'!
for: aCabin

	^self new initializeFor: aCabin! !


!classDefinition: #CabinMovingState category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
CabinState subclass: #CabinMovingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!CabinMovingState methodsFor: 'actions' stamp: 'HAW 10/3/2017 19:51:03'!
closeDoor
	
	cabin closeDoorWhenMoving! !


!CabinMovingState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:39:12'!
isMoving
	
	^true! !

!CabinMovingState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:39:02'!
isStopped
	
	^false! !

!CabinMovingState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:29:37'!
isWaitingForPeople

	^false! !


!CabinMovingState methodsFor: 'visitor' stamp: 'HAW 10/4/2017 14:07:12'!
accept: aVisitor

	aVisitor visitCabinMoving: self! !


!classDefinition: #CabinStoppedState category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
CabinState subclass: #CabinStoppedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!CabinStoppedState methodsFor: 'actions' stamp: 'HAW 10/3/2017 19:56:06'!
closeDoor
	
	cabin closeDoorWhenStopped! !


!CabinStoppedState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:19:55'!
isMoving
	
	^false! !

!CabinStoppedState methodsFor: 'testing' stamp: 'HAW 10/3/2017 15:53:39'!
isStopped

	^true! !

!CabinStoppedState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:29:42'!
isWaitingForPeople

	^false! !


!CabinStoppedState methodsFor: 'visitor' stamp: 'HAW 10/4/2017 14:07:50'!
accept: aVisitor

	aVisitor visitCabinStopped: self! !


!classDefinition: #CabinWaitingForPeopleState category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
CabinState subclass: #CabinWaitingForPeopleState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!CabinWaitingForPeopleState methodsFor: 'actions' stamp: 'HAW 10/3/2017 19:44:54'!
closeDoor
	
	cabin closeDoorWhenWaitingForPeople! !


!CabinWaitingForPeopleState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:29:50'!
isMoving

	^false! !

!CabinWaitingForPeopleState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:30:07'!
isStopped

	^false! !

!CabinWaitingForPeopleState methodsFor: 'testing' stamp: 'HAW 10/3/2017 19:39:02'!
isWaitingForPeople
	
	^true! !


!CabinWaitingForPeopleState methodsFor: 'visitor' stamp: 'HAW 10/4/2017 14:19:42'!
accept: aVisitor

	aVisitor visitCabinWaitingForPeople: self! !


!classDefinition: #Elevator category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
Object subclass: #Elevator
	instanceVariableNames: 'cabin state floorsToGo suscriptors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!Elevator methodsFor: 'initialization' stamp: 'GF 10/12/2017 19:37:06'!
initialize

	cabin := Cabin of: self.
	floorsToGo := SortedCollection new.
	state := ElevatorIdleState for: self.
	suscriptors := Set new.! !


!Elevator methodsFor: 'state change' stamp: 'HAW 10/3/2017 16:56:07'!
makeIdle
	
	state := ElevatorIdleState for: self! !

!Elevator methodsFor: 'state change' stamp: 'HAW 10/3/2017 16:12:35'!
makeWorking
	
	state := ElevatorWorkingState for: self! !


!Elevator methodsFor: 'actions' stamp: 'HAW 10/3/2017 16:07:55'!
goUpPushedFromFloor: aFloorNumber

	^state goUpPushedFromFloor: aFloorNumber! !


!Elevator methodsFor: 'actions - private' stamp: 'HAW 10/3/2017 16:10:27'!
goUpPushedFromFloorWhenIdle: aFloorNumber

	self startWorkingGoingTo: aFloorNumber ! !

!Elevator methodsFor: 'actions - private' stamp: 'HAW 10/3/2017 19:36:33'!
goUpPushedFromFloorWhenWorking: aFloorNumber 

	self queFloorToGo: aFloorNumber ! !

!Elevator methodsFor: 'actions - private' stamp: 'HAW 10/4/2017 10:10:09'!
jobDone
	
	self makeIdle ! !

!Elevator methodsFor: 'actions - private' stamp: 'HAW 10/3/2017 16:11:45'!
queFloorToGo: aFloorNumber

	floorsToGo add: aFloorNumber ! !

!Elevator methodsFor: 'actions - private' stamp: 'HAW 10/3/2017 16:47:57'!
reachedFloorToStop
	
	floorsToGo removeFirst ! !

!Elevator methodsFor: 'actions - private' stamp: 'HAW 10/3/2017 16:11:18'!
startWorkingGoingTo: aFloorNumber

	self queFloorToGo: aFloorNumber.
	self makeWorking.
	cabin startClosingDoor.! !


!Elevator methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:55:48'!
hasFloorsToGo
	
	^floorsToGo notEmpty! !

!Elevator methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:46:50'!
hasToStopOnCurrentFloor
	
	^floorsToGo first = cabin currentFloorNumber ! !

!Elevator methodsFor: 'testing' stamp: 'HAW 10/3/2017 15:45:45'!
isIdle

	^state isIdle! !

!Elevator methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:18:55'!
isWorking
	
	^state isWorking! !


!Elevator methodsFor: 'cabin' stamp: 'HAW 10/4/2017 09:59:35'!
cabin
	
	^cabin! !


!Elevator methodsFor: 'as yet unclassified' stamp: 'GF 10/12/2017 19:39:24'!
subscribe: anElevatorConsole 
	
	suscriptors add: anElevatorConsole.
	cabin subscribe: anElevatorConsole.
	! !


!classDefinition: #ElevatorConsole category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
Object subclass: #ElevatorConsole
	instanceVariableNames: 'stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!ElevatorConsole methodsFor: 'initialization' stamp: 'GF 10/12/2017 19:34:26'!
initializeOf: anElevator
	
	stream := WriteStream on: String new.
	anElevator subscribe: self.
! !


!ElevatorConsole methodsFor: 'accessing' stamp: 'HAW 10/4/2017 12:41:14'!
consoleReadStream
	
	^ ReadStream on: stream contents ! !


!ElevatorConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:06:45'!
visitCabinDoorClosed: aCabinDoorClosedState 

	stream 
		nextPutAll: 'Puerta Cerrada';
		newLine! !

!ElevatorConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:02:43'!
visitCabinDoorClosing: aCabinDoorClosingState 
	
	stream 
		nextPutAll: 'Puerta Cerrandose';
		newLine! !

!ElevatorConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:18:17'!
visitCabinDoorOpened: aCabinDoorOpenedState 
! !

!ElevatorConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:08:27'!
visitCabinDoorOpening: aCabinDoorOpeningState 

	stream 
		nextPutAll: 'Puerta Abriendose'  ;
		newLine! !

!ElevatorConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:07:21'!
visitCabinMoving: aCabinMovingState 
	
	stream 
		nextPutAll: 'Cabina Moviendose'  ;
		newLine! !

!ElevatorConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:07:59'!
visitCabinStopped: aCabinStoppedState 
	
	stream 
		nextPutAll: 'Cabina Detenida' ;
		newLine! !

!ElevatorConsole methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:20:06'!
visitCabinWaitingForPeople: aCabinWaitingForPeopleState 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorConsole class' category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
ElevatorConsole class
	instanceVariableNames: ''!

!ElevatorConsole class methodsFor: 'instance creation' stamp: 'HAW 10/4/2017 12:46:15'!
of: anElevator

	^ self new initializeOf: anElevator  ! !


!classDefinition: #ElevatorState category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
Object subclass: #ElevatorState
	instanceVariableNames: 'elevator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!


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


!ElevatorState methodsFor: 'initialization' stamp: 'HAW 10/3/2017 15:52:01'!
initializeFor: anElevator

	elevator := anElevator ! !


!ElevatorState methodsFor: 'actions' stamp: 'HAW 10/3/2017 20:22:29'!
goUpPushedFromFloor: aFloorNumber

	self subclassResponsibility ! !


!ElevatorState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:21:52'!
isIdle

	self subclassResponsibility ! !

!ElevatorState methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:21:56'!
isWorking

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorState class' category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
ElevatorState class
	instanceVariableNames: ''!

!ElevatorState class methodsFor: 'instance creation' stamp: 'HAW 10/3/2017 15:52:13'!
for: anElevator

	^self new initializeFor: anElevator ! !


!classDefinition: #ElevatorIdleState category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
ElevatorState subclass: #ElevatorIdleState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!ElevatorIdleState methodsFor: 'actions' stamp: 'HAW 10/3/2017 16:09:40'!
goUpPushedFromFloor: aFloorNumber

	^elevator goUpPushedFromFloorWhenIdle: aFloorNumber! !


!ElevatorIdleState methodsFor: 'testing' stamp: 'HAW 10/3/2017 15:47:41'!
isIdle

	^true! !

!ElevatorIdleState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:56:18'!
isWorking
	
	^false! !


!classDefinition: #ElevatorWorkingState category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
ElevatorState subclass: #ElevatorWorkingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!ElevatorWorkingState methodsFor: 'actions' stamp: 'HAW 10/3/2017 20:23:05'!
goUpPushedFromFloor: aFloorNumber

	^elevator goUpPushedFromFloorWhenWorking: aFloorNumber ! !


!ElevatorWorkingState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:18:43'!
isIdle
	
	^false! !

!ElevatorWorkingState methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:19:04'!
isWorking
	
	^true! !


!classDefinition: #ElevatorStatusView category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
Object subclass: #ElevatorStatusView
	instanceVariableNames: 'cabinDoorFieldModel cabinFieldModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!ElevatorStatusView methodsFor: 'initialization' stamp: 'GF 10/12/2017 20:26:55'!
initializeOf: anElevator

	anElevator subscribe: self.! !


!ElevatorStatusView methodsFor: 'accessing' stamp: 'HAW 10/4/2017 12:41:24'!
cabinDoorFieldModel
	
	^ cabinDoorFieldModel! !

!ElevatorStatusView methodsFor: 'accessing' stamp: 'HAW 10/4/2017 12:41:24'!
cabinFieldModel
	
	^ cabinFieldModel! !


!ElevatorStatusView methodsFor: 'visiting' stamp: 'HAW 10/4/2017 12:41:24'!
visitCabinDoorClosed: aCabinDoorClosedState 

	cabinDoorFieldModel := 'Closed'! !

!ElevatorStatusView methodsFor: 'visiting' stamp: 'HAW 10/4/2017 12:41:24'!
visitCabinDoorClosing: aCabinDoorClosingState 
	
	cabinDoorFieldModel := 'Closing'! !

!ElevatorStatusView methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:18:32'!
visitCabinDoorOpened: aCabinDoorOpenedState 

	cabinDoorFieldModel := 'Opened'! !

!ElevatorStatusView methodsFor: 'visiting' stamp: 'HAW 10/4/2017 12:41:24'!
visitCabinDoorOpening: aCabinDoorOpeningState 

	cabinDoorFieldModel := 'Opening'! !

!ElevatorStatusView methodsFor: 'visiting' stamp: 'HAW 10/4/2017 12:41:24'!
visitCabinMoving: aCabinMovingState 
	
	cabinFieldModel := 'Moving'! !

!ElevatorStatusView methodsFor: 'visiting' stamp: 'HAW 10/4/2017 12:41:24'!
visitCabinStopped: aCabinStoppedState 
	
	cabinFieldModel := 'Stopped'! !

!ElevatorStatusView methodsFor: 'visiting' stamp: 'HAW 10/4/2017 14:20:21'!
visitCabinWaitingForPeople: aCabinWaitingForPeopleState 
	
	cabinFieldModel := 'Waiting for People'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorStatusView class' category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
ElevatorStatusView class
	instanceVariableNames: ''!

!ElevatorStatusView class methodsFor: 'instance creation' stamp: 'HAW 10/4/2017 12:46:55'!
of: anElevator

	^ self new initializeOf: anElevator! !


!classDefinition: #Motor category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
Object subclass: #Motor
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!

!Motor methodsFor: 'initialization' stamp: 'HAW 10/3/2017 16:16:34'!
initialize

	state := #stopped! !


!Motor methodsFor: 'actions' stamp: 'HAW 10/3/2017 16:17:14'!
moveClockwise
	
	self assertIsNotMoving.
	
	state := #movingClockwise! !

!Motor methodsFor: 'actions' stamp: 'HAW 10/3/2017 21:41:43'!
moveCounterClockwise
	
	self assertIsNotMoving.
	
	state := #movingCounterClockwise! !

!Motor methodsFor: 'actions' stamp: 'HAW 10/3/2017 16:37:55'!
stop
	
	state := #stopped! !


!Motor methodsFor: 'testing' stamp: 'HAW 10/3/2017 20:16:07'!
isMoving
	
	^self isStopped not! !

!Motor methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:25:52'!
isMovingClockwise
	
	^state = #movingClockwise! !

!Motor methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:52:29'!
isMovingCounterClockwise
	
	^state = #movingCounterClockwise ! !

!Motor methodsFor: 'testing' stamp: 'HAW 10/3/2017 16:26:30'!
isStopped
	
	^state = #stopped! !


!Motor methodsFor: 'assertions' stamp: 'HAW 10/3/2017 20:17:33'!
assertIsNotMoving
	
	self isMoving ifTrue: [ self signalMotorMustBeStoppedBeforeMovingAgain]! !


!Motor methodsFor: 'exceptions' stamp: 'HAW 10/3/2017 20:18:10'!
motorMustBeStoppedBeforeMovingAgainErrorMessage

	^self class motorMustBeStoppedBeforeMovingAgainErrorMessage
! !

!Motor methodsFor: 'exceptions' stamp: 'HAW 10/3/2017 20:17:56'!
signalMotorMustBeStoppedBeforeMovingAgain

	self error: self motorMustBeStoppedBeforeMovingAgainErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Motor class' category: #'ElevatorConsole-Simple with Cabin-Door-Motor-Ejercicio'!
Motor class
	instanceVariableNames: ''!

!Motor class methodsFor: 'exceptions' stamp: 'HAW 10/3/2017 20:18:35'!
motorMustBeStoppedBeforeMovingAgainErrorMessage

	^'El motor debe estar parado antes de que se empiece a mover'! !
