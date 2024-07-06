extends CharacterBody2D
var bug_health:int = 30
var player_notice: bool = false
var player_inrange: bool = false
var direction: Vector2
var speed:int = 200
var vulnerable: bool = true

func hit():
	if vulnerable:
		vulnerable = false
		$Timer/HitTimer.start()
		bug_health -= 10
		$AnimatedSprite2D.material.set_shader_parameter("progress", 0.7)
		$Particles/HitParticle.emitting = true
	if bug_health<=0:
		await get_tree().create_timer(0.5).timeout
		queue_free()

func _process(_delta):
	direction= (Globals.player_pos - position).normalized()
	velocity = direction*speed
	if player_notice:
		move_and_slide()
		look_at(Globals.player_pos)

func _on_notice_area_body_entered(_body):
	player_notice = true
	$AnimatedSprite2D.play('walk')

func _on_notice_area_body_exited(_body):
	player_notice = false
	#print(body)
	$AnimatedSprite2D.stop()

func _on_attack_area_body_entered(_body):
	player_inrange = true
	$AnimatedSprite2D.play('attack')

func _on_attack_area_body_exited(_body):
	player_inrange= false
	#$AnimatedSprite2D.stop()
	
func _on_animated_sprite_2d_animation_finished():
	#print('workkkkkk')
	if player_inrange:
		Globals.health -= 10
		$Timer/AttackTimer.start()

func _on_attack_timer_timeout():
	$AnimatedSprite2D.play('attack')


func _on_hit_timer_timeout():
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress",0)
