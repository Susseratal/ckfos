extends Node3D

class_name NpcSpawner

const spawnRangeMin: float = -5
const spawnRangeMax: float = 5
const maxNpcCount: int = 5

var npcCount: int = 0
@export var NPC: PackedScene # preload("res://InteractiveObjects/NPC.tscn")
var rng = RandomNumberGenerator.new()
var delay = 0
var parent = null
var spawnLocation: Vector3 = Vector3(0.0, 0.0, 0.0)
var npcNames = ["Kevin", "Percival", "Maria", "Janice", "Marvin", "Gorgonzola", "Gordon", "Micheal", "Harold", "Julie", 
				"Melissa", "Nigel", "Steven", "Beth", "Leon", "Claire", "Norman", "Nolan", "Nathan", "Joel", "Ellie"]
var playerRef = null
var timerComplete = false

func _init() -> void:
	pass

func _ready() -> void:
	parent = self.get_parent()
	pass

func _process(_delta: float) -> void:
	if npcCount >= maxNpcCount:
		return
	else:
		spawnLocation = Vector3(rng.randf_range(spawnRangeMin, spawnRangeMax), 0.05, rng.randf_range(spawnRangeMin, spawnRangeMax))
		# var character: npc = npcRef.instantiate(PackedScene.GEN_EDIT_STATE_MAIN)
		# var character: npc = NPC.instantiate()
		var character = NPC.instantiate()
		character.global_position = spawnLocation
		var randName = npcNames[rng.randi_range(0, npcNames.size() - 1)]
		character.selfName = randName
		character.npcSpawner = self
		add_child(character)
		npcCount += 1

func NpcDeathNotify():
	npcCount -= 1

func QueryPlayerLocation():
	if playerRef != null:
		return playerRef.QueryLocation()
	else:
		return Vector3(0, 0, 0)
