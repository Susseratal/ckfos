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
