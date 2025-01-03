extends Node3D

class_name npc

@export var movementSpeed: float = 4.0
@export var selfName: String
@onready var navAgent = $NavAgent
@onready var selfBody = $CharacterBody3D

var movementDelta: float
var rng = RandomNumberGenerator.new()
var isAlive: bool = true
var canMove: bool = true
var isMoving: bool = false
var walletPinched: bool = false
var npcSpawner: NpcSpawner = null
var hasTargetLocation: bool = false
var targetLocation: Vector3 = Vector3(0, 0, 0)

func _obstacle_avoided():
	print_debug("obstacle avoided")
	pass

func _velocity_computed(safe_velocity: Vector3) -> void:
	print_debug("velocity computerd")
	global_position = global_position.move_toward(global_position + safe_velocity, movementDelta)

func _init() -> void:
	pass

func _ready() -> void:
	var agent: RID = navAgent.get_rid()
	NavigationServer3D.agent_set_avoidance_enabled(agent, true)
	NavigationServer3D.agent_set_avoidance_callback(agent, Callable(self, "_obstacle_avoided"))
	NavigationServer3D.agent_set_use_3d_avoidance(agent, true)
	navAgent.velocity_computed.connect(Callable(_velocity_computed))
	
func SetMovementTarget(movementTarget: Vector3, velocity: Vector3):
	navAgent.set_target_position(movementTarget)
	navAgent.set_velocity(velocity)
	global_position.move_toward(movementTarget, movementDelta)

func GetNewLocation():
	var outLocation: Vector3 = Vector3(0, 0, 0)
	if (rng.randi_range(1, 5) == 4):
		outLocation = npcSpawner.QueryPlayerLocation()
	else:
		outLocation = Vector3(rng.randf_range(-250, 250), 0, rng.randf_range(-250, 250))
	return outLocation

func ClearTargetLocation():
	hasTargetLocation = false

func _process(delta: float) -> void:
	if isAlive && !isMoving:
		if !hasTargetLocation:
			if true or (rng.randi_range(1, 30) == 15):
				targetLocation = GetNewLocation()
				hasTargetLocation = true
		else:
			isMoving = true
			movementDelta = movementSpeed * delta
			# var next_path_position: Vector3 = navAgent.get_next_path_position()
			var newVelocity: Vector3 = global_position.direction_to(targetLocation) * movementDelta
			SetMovementTarget(targetLocation, newVelocity)
			look_at(targetLocation)
			selfBody.velocity = newVelocity
			selfBody.move_and_slide()
	
	if navAgent.is_target_reached():
		isMoving = false
		return
	
	#if navAgent.is_navigation_finished():
		#print_debug("nav finished")
		#isMoving = false
		## ClearTargetLocation()
		#return

func Grab(instigator):
	if !walletPinched:
		var walletContents = rng.randi_range(2, 7)
		instigator.UpdateMoney(walletContents)
		instigator.hud.Notify("You pilfer $" + str(walletContents))
		walletPinched = true
	else:
		instigator.hud.Notify("No more money to pilfer")
	### Hold the NPCs in front of you and be able to throw them at buildings

func Identify(instigator):
	var diceRoll = rng.randi_range(1, 12)
	var outText = ""
	if diceRoll == 4:
		outText = "Kill them, eat them, kill them, eat them"
	else:
		outText = str("This is " + selfName)
	instigator.hud.Notify(outText)
	pass

func Insult(_instigator):
	canMove = false
	pass

func Speak(instigator):
	if isAlive:
		instigator.hud.Notify("You may not feast while they yet live")
	else:
		pass
		# canMove = false
	
func Kill(instigator):
	if npcSpawner != null:
		npcSpawner.NpcDeathNotify()
		self.queue_free()
	else:
		instigator.hud.Notify("null spawner")
