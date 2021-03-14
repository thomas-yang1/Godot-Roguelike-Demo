extends Node2D
class_name Main

onready var playerStats = PlayerStats
onready var audio = AudioControl

var has_combat := false
var low_health := false


func _ready() -> void:
	audio._set_theme_track()
	playerStats.connect("health_changed", self, "_on_Player_health_changed")
	playerStats.connect("no_health", self, "_on_Player_died")


func _on_Enter_combat():
	has_combat = true
	audio._start_combat_track()


func _on_Exit_combat():
	has_combat = false
	audio._stop_combat_track()


# warning-ignore:unused_argument
func _on_Player_health_changed(value):
# warning-ignore:integer_division
	var half_health = PlayerStats.max_health / 2

	if playerStats.health == half_health -1:
		audio._set_theme_track()
	

func _on_Player_died() -> void:
	audio._set_death_track()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/Level/GameOver.tscn")
