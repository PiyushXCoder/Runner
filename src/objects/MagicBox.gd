extends Area2D
class_name MagicBox

onready var grid: TileMap = get_parent().get_parent()
onready var collision = $CollisionShape2D

var coinflip = preload('res://src/objects/CoinFlip.tscn')

enum Type {LEFT_BLOCK = 45, MID_BLOCK = 46, RIGHT_BLOCK = 47}

export(Type) var type = Type.LEFT_BLOCK

func _physics_process(_delta: float) -> void:
	for bd in get_overlapping_bodies():
		if bd is Player:
			grid.set_cellv(grid.world_to_map(get_child(0).get_position()), type)
			Global.score += Global.SCORE_COIN
			Global.coins += 1
			collision.set_disabled(true)
			
			var coin = coinflip.instance()
			coin.global_position = get_child(0).global_position
			coin.set_as_toplevel(true)
			add_child(coin)
