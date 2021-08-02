extends Control

onready var resume_button = $ResumeButton

func _ready() -> void:
	hide()

func _input(event):
	if Input.is_action_just_pressed('pause'):
		open()

func open():
	show()
	get_tree().paused = true
	resume_button.grab_focus()

func close():
	hide()
	get_tree().paused = false

func _on_ResumeButton_pressed() -> void:
	close()

func _on_ExitButton_pressed() -> void:
	close()
	get_tree().change_scene("res://src/scenes/MainMenu.tscn")
