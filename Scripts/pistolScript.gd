extends Node3D

class_name Pistol

const MAX_AMMO_COUNT: int = 12

@export var ammoCount: int = MAX_AMMO_COUNT
# var owningObject: Node3D
@onready var mesh = $GunMesh

var rp = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# var mat = mesh.get_surface_override_material(0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func GetAmmoCount():
	return ammoCount

func Reload():
	## reload anim
	ammoCount = MAX_AMMO_COUNT

func FireGun():
	if ammoCount == 0:
		return false
	else:
		## TODO shoot anim goes here
		ammoCount -= 1
		return true
