extends ItemContainer

func hit():
	if not opened:
		opened=true
		$LidSprite.hide()
		for i in range(5):
			var pos= $SpawnPos.get_child(randi()%$SpawnPos.get_child_count()).global_position
			open.emit(pos,current_direction)
	
