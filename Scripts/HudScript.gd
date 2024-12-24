extends Control

@onready var healthIcon = $healthSprite
@onready var interactPrompt = $interactPrompt

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
		1:
			interactPrompt.texture = load("res://Assets/1_Point.png")
		2:
			interactPrompt.texture = load("res://Assets/2_insult.png")
		_:
			pass
