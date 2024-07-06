extends Node2D

var target_pos:Vector2 = Vector2.ZERO
func _physics_process(_delta):
	await get_tree().physics_frame
	$NavigationRegion2D/NavigationAgent2D.target_position = target_pos
	print($NavigationRegion2D/NavigationAgent2D.get_next_path_position())
