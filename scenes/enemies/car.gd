extends PathFollow2D

var player_near:bool = false
@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D

func fire():
	Globals.health -=10

func _ready():
	line2.add_point($Turret/RayCast2D2.target_position)

func _process(delta):
	progress_ratio += 0.05*delta
	if player_near:
		$Turret.look_at(Globals.player_pos)


func _on_notice_area_body_entered(_body):
	player_near =true
	$AnimationPlayer.play("laser_load")

func _on_notice_area_body_exited(_body):
	player_near =false
	$AnimationPlayer.pause()
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(line1, 'width', 0, randf_range(0.1,0.5))
	tween.tween_property(line2, 'width', 0, randf_range(0.1,0.5))
	await tween.finished
	$AnimationPlayer.stop()
