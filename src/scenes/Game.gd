extends Node2D
class_name Game

func _ready() -> void:
	Global.score = 0
	Global.coins = 0
	
	if !OS.has_touchscreen_ui_hint():
		var info = load('res://src/layers/HelpInfo.tscn').instance()
		info.global_position = $HelpHere.global_position
		add_child(info)
