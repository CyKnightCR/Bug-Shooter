extends RigidBody2D
var exploding: bool = false
const speed: int = 600
var explosion_radius:int = 200
func _process(_delta):
	if exploding:
		var targets = get_tree().get_nodes_in_group('Container') + get_tree().get_nodes_in_group('Entity')
		for target in targets:
			var in_range:bool = global_position.distance_to(target.global_position)<explosion_radius
			if 'hit' in target and in_range:
				target.hit() 

func explode():
	$AnimationPlayer.play("Explosion")
	exploding = true 
	

