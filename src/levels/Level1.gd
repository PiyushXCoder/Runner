extends Node2D

func _on_Area2D_body_entered(_body: Node) -> void:
	if get_tree().change_scene("res://src/scenes/GameWon.tscn") != 0:
		print('Failed to change scene')
		get_tree().quit()
