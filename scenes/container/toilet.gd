extends ItemContainer

func hit():
	if not opened:
		opened=true
		$LidSprite.hide()
		open.emit($SpawnPos/Marker2D.global_position, current_direction)
	

