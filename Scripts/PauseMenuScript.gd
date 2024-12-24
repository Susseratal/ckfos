extends Control

@onready var playButton = $VBoxContainer/Play
@onready var quitButton = $VBoxContainer/Quit
@onready var playerRef = $"../../.."

func _on_play_pressed() -> void:
	playerRef.TogglePause()

func _on_quit_pressed() -> void:
	get_tree().quit()
