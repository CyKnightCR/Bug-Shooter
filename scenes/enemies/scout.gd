extends CharacterBody2D
signal laser(pos, direction)
var player_nearby:bool = false
var can_laser: bool= true
var health:int = 30
var vulnerable: bool = true
var gun:bool = 0
func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var pos: Vector2
			pos=$LaerSpawnPos.get_child(gun).global_position
			gun=!gun
			var direction: Vector2 = (Globals.player_pos - global_position).normalized()
			laser.emit(pos,direction)
			can_laser=false
			$LaserCooldown.start()

func _on_attack_area_body_entered(_body):
	player_nearby=true

func _on_attack_area_body_exited(_body):
	player_nearby=false

func _on_timer_timeout():
	can_laser=true

func hit():
	if vulnerable:
		health -=10
		vulnerable = false
		$Scout.material.set_shader_parameter("progress",0.7)
		$Invulnerable.start()
	if health <=0:
		queue_free()

func _on_invulnerable_timeout():
	vulnerable=true
	$Scout.material.set_shader_parameter("progress",0)
