extends Node3D

var rng = RandomNumberGenerator.new()

## TODO somewhere in here figure out how to make the NPCs walk around

func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func Grab(instigator):
	### Hold the NPCs in front of you and be able to throw them at buildings
	pass
	
func Identify(instigator):
	var diceRoll = rng.randi_range(1, 6)
	var outText = ""
	if diceRoll == 4:
		outText = "Kill them, eat them, kill them, eat them"
	else:
		outText = "This is a person"
	instigator.hud.Notify(outText)
	pass
	
func Insult(instigator):
	pass

func Speak(instigator):
	### eat them
	pass
	
func Kick(instigator):
	### kill them
	pass

## TODO figure out some basic item interactions 

## TODO build and be done 
