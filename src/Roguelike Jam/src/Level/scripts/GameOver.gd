extends Control


func _on_Button_pressed():
	PlayerStats.health = PlayerStats.max_health
	AudioControl._set_process(true)
	get_tree().change_scene("res://src/Level/BoxLevel.tscn")
