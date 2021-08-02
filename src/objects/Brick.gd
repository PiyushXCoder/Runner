extends Area2D
class_name Brick

onready var grid: TileMap = get_parent().get_parent()
onready var collision = $CollisionShape2D

var brokenbrick = preload('res://src/objects/BrokenBrick.tscn')

func _physics_process(_delta: float) -> void:
	for bd in get_overlapping_bodies():
		if bd is Player:
			grid.set_cellv(grid.world_to_map(get_child(0).get_position()), -1)
			collision.set_disabled(true)
			
			var broken = brokenbrick.instance()
			broken.global_position = get_child(0).global_position
			broken.set_as_toplevel(true)
			add_child(broken)
