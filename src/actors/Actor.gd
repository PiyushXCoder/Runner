extends KinematicBody2D
class_name Actor

export var speed: = Vector2(250,500)
export var gravity: float = ProjectSettings.get("physics/2d/default_gravity")

const FLOOR_NORMAL = Vector2.UP

var _velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
