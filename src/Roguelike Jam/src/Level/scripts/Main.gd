extends Node2D
class_name Main

onready var playerStats = PlayerStats
onready var audio = AudioControl

var has_combat := false
var low_health := false


func _ready() -> void:
	audio.set_main_scene()
	playerStats.connect("health_changed", self, "_on_Player_health_changed")
	

func _on_Enter_combat():
	has_combat = true
	audio.select_audio_track()


func _on_Exit_combat():
	has_combat = false
	audio.select_audio_track()


func _on_Player_health_changed(value):
	audio._update_tracks(value)
