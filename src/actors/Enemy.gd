extends 'res://src/actors/Actor.gd'
class_name Enemy

onready var right_platform_detector = $RightPlatformDetector
onready var left_platform_detector = $LeftPlatformDetector
onready var sprite = $AnimatedSprite
onready var collision_shape = $CollisionShape2D
onready var shot_timer = $Shot
onready var destroy_timer = $Destroy
onready var die_audio = $AudioStreamPlayer2D
onready var left_right_collision_detector = $LeftRightCollisionDetector
onready var top_collision_detector = $TopCollisionDetector

export var direction = -1
var current_animation = 'run'
var self_destroy = false
var got_shot = false
var killed_player = false

export var turn_back_on_fall = false

func _physics_process(_delta: float) -> void:
	if got_shot or self_destroy:
		set_collision_mask_bit(0, false)
		left_right_collision_detector.set_collision_mask_bit(0, false)
		top_collision_detector.set_collision_mask_bit(0, false)
	
	_velocity.x = get_direction() * speed.x
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	# Flip if needed
	if direction > 0:
		sprite.set_flip_h(true)
	elif direction < 0:
		sprite.set_flip_h(false)
	
	var animaton = get_animation()
	if sprite.animation != animaton:
		sprite.play(animaton)

func get_direction() -> int:
	if got_shot or self_destroy or killed_player:
		return 0
	
	if is_on_wall():
		direction *= -1  
	
	if !turn_back_on_fall:
		return direction
	
	var right = right_platform_detector.is_colliding()
	var left = left_platform_detector.is_colliding()
	if right and !left:
		direction = 1
	elif !right and left:
		direction = -1
	elif !right and !left:
		direction = 0
	return direction

func get_animation() -> String:
	if self_destroy:
		return 'die'
	elif got_shot:
		return 'hit'
	else:
		return 'run'

func kill_me():
	if !got_shot and !self_destroy:
		Global.score += Global.SCORE_KILL
		die_audio.play()
		got_shot = true
		shot_timer.start()

func _on_Shot_timeout() -> void:
	self_destroy = true
	destroy_timer.start()

func _destroy() -> void:
	queue_free()
	pass

func _on_LeftRightCollisionDetector_body_entered(body: Node) -> void:
	if body is Player:
		killed_player = true
		body.kill_me()

func _on_TopCollisionDetector_body_entered(body: Node) -> void:
	if body is Player:
		kill_me()
