extends Position2D
class_name Gun

const bullet_velocity = 800
const Bullet = preload('res://src/objects/Bullet.tscn')

func shoot(direction: int):
	var bullet = Bullet.instance()
	bullet.set_position(global_position)
	bullet.linear_velocity = Vector2(direction * bullet_velocity, 0)
	bullet.set_as_toplevel(true)
	add_child(bullet)
