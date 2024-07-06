extends CharacterBody2D
var can_laser: bool = true
var can_grenade: bool = true
signal laser_fired(pos,player_direction)
signal grenade_fired(pos,player_direction)

@export var max_speed :int = 1000
var speed:int = max_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	$GPUParticles2D.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	rotate player
	
	look_at(get_global_mouse_position())
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction*speed
	move_and_slide()
	Globals.player_pos=global_position
	
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_just_pressed("primary action") and can_laser and Globals.laser_amount>0:
		Globals.laser_amount-=1
		var laser_markers =  $LaserStartPos.get_children()
		var selected_laser = laser_markers[ randi() % laser_markers.size()]		
		laser_fired.emit(selected_laser.global_position, player_direction)
		can_laser = false
		$LaserTimer.start(0.3)
		$GPUParticles2D.emitting = true
	
	if Input.is_action_just_pressed("secondary action") and can_grenade and Globals.grenade_amount>0:
		Globals.grenade_amount-=1
		can_grenade = false
		$GrenadeTimer.start(2)
		grenade_fired.emit($LaserStartPos/Marker2D2.global_position,player_direction)

func _on_timer_timeout():
	can_laser=true

func _on_grenade_timer_timeout():
	can_grenade=true

func hit():
	Globals.health -= 10
