extends Node2D

onready var animation = $AnimationPlayer
onready var audio = $AudioStreamPlayer2D

func _ready() -> void:
	animation.play('flip')
	audio.play()

func _on_Timer_timeout() -> void:
	queue_free()
