extends CharacterBody2D
var active:bool = false
var speed:int = 0
var max_speed:int = 1200
var speed_mult:int = 1
var vulnerable:bool = true
var health:int = 40
var explosion_active =false

func _ready():
	$Explosion.hide()
	$Drone.show()

func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity=direction*speed*speed_mult
		var coll= move_and_collide(velocity*delta)
		if coll:
			$AnimationPlayer.play("explosion")
			explosion_active= true
	if explosion_active:
		var targets= get_tree().get_nodes_in_group('Entity') + get_tree().get_nodes_in_group('Container')
		for target in targets:
			var in_range = position.distance_to(target.global_position)<400
			if in_range and "hit" in target:
				target.hit()

func hit():
	if vulnerable:
		health-=10 
		vulnerable= false
		$HitTimer.start()
		$Drone.material.set_shader_parameter('progress',0.7)
	if health<=0:
		$AnimationPlayer.play('explosion')
		explosion_active= true


func _on_notice_area_body_entered(_body):
	active=true
	var tween = create_tween()
	tween.tween_property(self,"speed",max_speed,5)


func _on_hit_timer_timeout():
	vulnerable=true
	$Drone.material.set_shader_parameter('progress',0)

func stop():
	speed_mult = 0
