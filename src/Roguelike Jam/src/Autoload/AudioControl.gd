extends AudioStreamPlayer

onready var playerStats = PlayerStats
onready var main

onready var normal_BGM :Resource = preload("res://asset/audio/Dark Main Theme v2.0.wav")
onready var	normal_low_hp_BGM :Resource = preload("res://asset/audio/Dark Main Theme Low Health.wav")
onready var combat_BGM :Resource = preload("res://asset/audio/Combat Track V2.wav")
onready var	combat_low_hp_BGM :Resource = preload("res://asset/audio/Combat Track_Low Health.wav")

var current_normal_BGM :Resource
var current_combat_BGM :Resource


func _ready() -> void:
	set_tracks()
	

func _set_process(value) -> void:
	if value:
		main = get_tree().root.get_child_count() - 1
		main = get_tree().root.get_child(main)
		stream_paused = false
		play_audio(normal_BGM)
	
	else:
		main = null
		stream_paused = true
		
		set_tracks()
		

func set_tracks() -> void:
	current_normal_BGM = normal_BGM
	current_combat_BGM = combat_BGM


func set_main_scene() -> void:
	main = get_tree().root.get_child_count() - 1
	main = get_tree().root.get_child(main)
	


func _update_tracks(value) -> void:
	var low_health = main.low_health

	if not low_health and value <= playerStats.max_health / 2:
		current_normal_BGM = normal_low_hp_BGM
		current_combat_BGM = combat_low_hp_BGM

		low_health = true

		select_audio_track()

	if low_health:
		if value > playerStats.max_health / 2:
			current_normal_BGM = normal_BGM
			current_combat_BGM = combat_BGM

			select_audio_track()


func select_audio_track() -> void:
	if main.has_combat:
		play_audio(current_combat_BGM)

	else:
		play_audio(current_normal_BGM)


func play_audio(track :Resource) -> void:
	stream = track
	play()
