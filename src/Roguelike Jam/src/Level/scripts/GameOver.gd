extends Control


func _on_Button_pressed():
	PlayerStats.health = PlayerStats.max_health
	get_tree().change_scene("res://src/Level/BoxLevel.tscn")
