extends Node3D

@onready var playerRef = $"Player/CharacterBody3D"
@onready var npcSpawnerRef = $"NpcSpawner"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	npcSpawnerRef.playerRef = playerRef
	NavigationServer3D.set_debug_enabled(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
