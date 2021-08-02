extends 'res://src/actors/Actor.gd'
class_name Player

const FLOOR_DETECT_DISTANCE = 20

onready var platform_detector = $PlatformDetector
onready var sprite = $AnimatedSprite
onready var collision_shape = $CollisionPolygon2D
onready var die_timer = $Die
onready var camera = $Camera2D

onready var jump_audio = $JumpAudio
onready var hit_audio = $HitAudio
onready var shoot_audio = $ShootAudio

onready var gun_right = $GunRight
onready var gun_left = $GunLeft

var current_animation = 'idle'
var self_distruct = false

func _physics_process(_delta: float) -> void:
	#calculate direction
	var direction = get_direction()
	
	if Input.is_action_just_pressed('jump'):
		jump_audio.play()
	
	var is_jump_interrupted = Input.is_action_just_released('jump') and _velocity.y < 0
	
	# calculate velocity
	_velocity = calculate_velocity(_velocity, speed, direction, is_jump_interrupted)
	
	# grown se paas hone pe non zero vector, zero hone par hi bas jump hota hai
	var snap_vector = Vector2.ZERO
	if direction.y == 0:
		snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE
		
	var is_on_platform = platform_detector.is_colliding()
	# move
	_velocity = move_and_slide_with_snap(_velocity, snap_vector, FLOOR_NORMAL, !is_on_platform, 4, 0.9, false)
	
	# Flip if needed and shoot with respective gun
	if direction.x > 0:
		sprite.set_flip_h(false)
	elif direction.x < 0:
		sprite.set_flip_h(true)
	
	if Input.is_action_just_pressed('shoot') and !self_distruct:
		shoot_audio.play()
		if sprite.flip_h:
			gun_left.shoot(-1)
		else:
			gun_right.shoot(1)
			
	# shoot
	var is_shooting = Input.is_action_pressed('shoot')
	
	var animaton = get_animation(is_on_platform,is_shooting)
	if sprite.animation != animaton:
		sprite.play(animaton)

func get_direction() -> Vector2:
	if self_distruct:
		return Vector2.ZERO
	
	return Vector2(
		Input.get_action_strength('move_right') - Input.get_action_strength('move_left'),
		-1 if Input.is_action_just_pressed('jump') and is_on_floor() else 0
	)

func calculate_velocity(linear_velocity, speed, direction, is_jump_interrupted) -> Vector2:
	var velocity = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0:
		velocity.y = speed.y * direction.y
	
	if is_jump_interrupted: # slow down aagar jump cor diya
		velocity.y *= 0.6
	return velocity

func get_animation(is_on_platform: bool, is_shooting: bool) -> String:
	if self_distruct:
		return 'hit'
	elif is_shooting:
		return 'shoot'
	elif !is_on_platform and _velocity.y > 0:
		return 'jump'
	elif !is_on_platform and _velocity.y < 0:
		return 'fall'
	elif _velocity.x != 0:
		return 'run'
	else:
		return 'idle'

func _on_VisibilityNotifier2D_screen_exited() -> void:
	if global_position.y > camera.limit_bottom:
		hit_audio.play()
		if get_tree().change_scene("res://src/scenes/GameOver.tscn") != 0:
			print('Failed to change scene')
			get_tree().quit()

func kill_me():
	hit_audio.play()
	self_distruct = true
	die_timer.start()

func _on_Die_timeout() -> void:
	if get_tree().change_scene("res://src/scenes/GameOver.tscn") != 0:
		print('Failed to change scene')
		get_tree().quit()
