extends Control
class_name MainMenu

onready var camera = $Camera2D
onready var play_button = $CanvasLayer/Control/PlayButton

func _ready() -> void:
	play_button.grab_focus()

func _physics_process(delta: float) -> void:
	camera.offset_h += 1.5 * delta

func _on_PlayButton_pressed() -> void:
	if get_tree().change_scene("res://src/scenes/Game.tscn") != 0:
		print('Failed to change scene')
		get_tree().quit()

func _on_ExitButton_pressed() -> void:
	get_tree().quit(0)
