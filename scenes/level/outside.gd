extends LevelParent
@export var inside_level_scene:PackedScene
func _on_gate_player_entered_gate():
	var tween= create_tween()
	tween.tween_property($Player,"speed",0,0.5)
	TransitionLayer.change_scene("res://scenes/level/inside.tscn")



func _on_house_player_entered_house():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D,"zoom",Vector2(0.8,0.8),1)


func _on_house_player_exited_house():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D,"zoom",Vector2(0.5,0.5),1)
