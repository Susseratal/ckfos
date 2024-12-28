extends Control

@onready var healthIcon = $healthSprite
@onready var interactPrompt = $interactPrompt
@onready var msgBox = $Label

func BeginPlay():
	healthIcon.play("HeartBeat")

func UpdateHealthUI(maxHealth, newHealth):
	var healthInverse = maxHealth - newHealth
	healthIcon.speed_scale = (healthInverse * 0.1)
	if newHealth == 0:
		healthIcon.speed_scale = 0
		
func ToggleInteractPrompt(newVisibility):
	interactPrompt.visible = newVisibility

func UpdateInteractPrompt(newMode):
	match newMode:
		0:
			interactPrompt.texture = load("res://Assets/0_Grip.png")
			Notify("Interact mode is GRAB")
		1:
			interactPrompt.texture = load("res://Assets/1_Point.png")
			Notify("Interact mode is IDENTIFY")
		2:
			interactPrompt.texture = load("res://Assets/3_Talk.png")
			Notify("Interact mode is EAT")
		3:
			interactPrompt.texture = load("res://Assets/4_Kick.png")
			Notify("Interact mode is KICK")
		_:
			pass
			
func Notify(notifyText):
	msgBox.text = notifyText
	msgBox.visible = true
	await get_tree().create_timer(.75).timeout
	msgBox.visible = false
