extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const GRAVITY = 9.8
const SENSITIVITY = 0.0075
const MAXHEALTH = 100

@onready var head = $Head
@onready var cam = $Head/Camera3D
@onready var hud = $Head/HudCanvas/HUD
@onready var menu = $Head/HudCanvas/PauseMenu
@onready var lineTrace = $Head/Camera3D/LineTrace
@onready var gun = $Head/Camera3D/gun

var i_health = MAXHEALTH
var b_inputProcessed = false
var b_mouseCaptured = false
var b_paused = false
var currentInteractRef: Object = null ## static typing my beloved
var i_interactMode: int = 0

func SetMouseCapture(b_newCaptured):
	if b_newCaptured == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		b_mouseCaptured = true
		hud.visible = true
		menu.visible = false
	elif b_newCaptured == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		b_mouseCaptured = false
		hud.visible = false
		menu.visible = true

func UpdateHealth(healthDelta):
	i_health = (i_health + healthDelta)
	hud.UpdateHealthUI(MAXHEALTH, i_health)
	
func TogglePause():
	b_paused = !b_paused
	SetMouseCapture(!b_paused)

func _ready():
	SetMouseCapture(true)
	hud.BeginPlay()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && b_mouseCaptured == true:
		self.rotate_y(-event.relative.x * SENSITIVITY)
		cam.rotate_x(-event.relative.y * SENSITIVITY)
		cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-85), deg_to_rad(85))
	
	elif event is InputEventKey:
		var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
		if(OS.get_keycode_string(keycode) == "J"): # processing twice because god hates me
			UpdateHealth(-10)
		elif(OS.get_keycode_string(keycode) == "K"):
			UpdateHealth(10)

func _physics_process(delta: float) -> void:
	# Add the gravity.	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	elif Input.is_action_just_pressed("Pause"):
		TogglePause()

### activate interaction
	elif Input.is_action_just_pressed("Interact"):
		if currentInteractRef != null:
			pass
		else:
			pass
			
			
	### interaction modes
	elif Input.is_action_just_pressed("SetInputMode1"):
		hud.UpdateInteractPrompt(0)
		i_interactMode = 0
		
	elif Input.is_action_just_pressed("SetInputMode2"):
		hud.UpdateInteractPrompt(1)
		i_interactMode = 1
		
	elif Input.is_action_just_pressed("SetInputMode3"):
		hud.UpdateInteractPrompt(2)
		i_interactMode = 2
	
	
	## interaction collider
	if lineTrace.get_collider() == null: 
		hud.ToggleInteractPrompt(false)
		currentInteractRef = null
		pass
	elif lineTrace.get_collider().get_parent().is_in_group("Interactive"):
		hud.ToggleInteractPrompt(true)
	else:
		hud.ToggleInteractPrompt(false)
		currentInteractRef = null

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if b_mouseCaptured == true:
		var input_dir := Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBack")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = 0.0
			velocity.z = 0.0

		move_and_slide()
