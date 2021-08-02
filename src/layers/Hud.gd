extends CanvasLayer
class_name Hud

onready var score = $Control/ColorRect/Score
onready var coins = $Control/ColorRect2/Coins
onready var timer = $Control/ColorRect3/Timer

onready var countdown = $CountDown


func _ready() -> void:
	update_values()

func _process(_delta: float) -> void:
	update_values()

func update_values():
	score.text = str(Global.score)
	coins.text = str(Global.coins)
	timer.text = str(ceil(countdown.time_left))


func _on_CountDown_timeout() -> void:
	if get_tree().change_scene("res://src/scenes/GameOver.tscn") != 0:
		print('Failed to change scene')
		get_tree().quit()
