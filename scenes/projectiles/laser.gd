extends Area2D
@export var speed:int = 2000
var direction
func _process(delta):
#	var direction = Vector2.UP
	position += direction*speed*delta
func _ready():
	$Timer.start(2)

func _on_body_entered(body):
	if "hit" in body :
		body.hit()
	#Oif body.name!="Player":#added this part to resolve issue
	queue_free()# on shooting opp to direc of moving laser was disappearing
#		because it was regestering player as body entered.
	


func _on_timer_timeout():
	queue_free()
