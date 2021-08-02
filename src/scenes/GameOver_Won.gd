extends Control
class_name GameOverOrWon

onready var camera = $Camera2D
onready var score = $CanvasLayer/Control/ColorRect2/Score
onready var coins = $CanvasLayer/Control/ColorRect3/Coins

onready var play_button = $CanvasLayer/Control/PlayButton

func _ready() -> void:
	score.text = str(Global.score)
	coins.text = str(Global.coins)
	play_button.grab_focus()

func _physics_process(delta: float) -> void:
	$Camera2D.offset_h += 2 * delta
	

func _on_PlayButton_pressed() -> void:
	if get_tree().change_scene("res://src/scenes/Game.tscn") != 0:
		print('Failed to change scene')
		get_tree().quit()


func _on_ExitButton_pressed() -> void:
	get_tree().quit(0)

func _on_MainMenuButton_pressed() -> void:
	if get_tree().change_scene("res://src/scenes/MainMenu.tscn") != 0:
		print('Failed to change scene')
		get_tree().quit()
