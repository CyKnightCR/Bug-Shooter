extends Node2D
signal stat_changed
var player_pos:Vector2
#signal laser_changed
#signal grenade_changed

var laser_amount=20:
	set(value):
		laser_amount=value
		stat_changed.emit()

var grenade_amount =5:
	set(value):
		grenade_amount=value
		stat_changed.emit()

var player_vulnerable: bool = true
var health=90:
	get:
		return health
	set(value):
		if value<health and player_vulnerable:
			health=min(value,100)
			health=max(value,0)
			
			player_vulnerable= false
			player_vulnerable_timer()
		if value>health:
			health=min(value,100)
		stat_changed.emit()

func player_vulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true

