extends RigidBody2D
class_name Bullet

func _on_Timer_timeout() -> void:
	queue_free()
	pass

func _on_body_entered(body):
	if body is Enemy:
		body.kill_me()
	pass
