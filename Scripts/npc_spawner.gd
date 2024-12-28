extends Node3D

var npc = preload("res://InteractiveObjects/NPC.tscn")
var rng = RandomNumberGenerator.new()
var delay = 0
var parent = null
var spawnLocation: Vector3 = Vector3(0.0, 0.0, 0.0)

func _init() -> void:
	pass

func _ready() -> void:
	parent = self.get_parent()
	pass

func _process(delta: float) -> void:
	delay = rng.randf_range(5.0, 15.0)
	spawnLocation = Vector3(rng.randf_range(-500, 500), 0, rng.randf_range(-500, 500))
	
	await get_tree().create_timer(delay).timeout
	
	var character = npc.instantiate(PackedScene.GEN_EDIT_STATE_MAIN)
	add_child(character) 
	character.global_position = spawnLocation
