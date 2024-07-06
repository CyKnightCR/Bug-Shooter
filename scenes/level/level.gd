extends Node2D
class_name LevelParent
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready():
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect('open',_on_container_opened)
		
	for scout in get_tree().get_nodes_in_group('Scouts'):
		scout.connect('laser', _on_scout_laser)

func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position=pos
	item.direction = direction
	$Items.call_deferred('add_child',item)
	
func _on_scout_laser(pos,direction):
	create_laser(pos,direction)
	
func _on_player_laser_fired(pos, player_direction):
	create_laser(pos,player_direction)

func create_laser(pos,direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.direction = direction
	laser.rotation_degrees = rad_to_deg(direction.angle())+90	
	$Projectiles.add_child(laser)

func _on_player_grenade_fired(pos, player_direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = player_direction*grenade.speed
	$Projectiles.add_child(grenade)
