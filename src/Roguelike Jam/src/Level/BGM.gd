extends AudioStreamPlayer

onready var audioControl = AudioControl
onready var playerStats = PlayerStats


func set_combat_bgm(value) -> void:
	audioControl.current_combat_BGM = value


func set_normal_bgm(value) -> void:
	audioControl.current_combat_BGM = value
	

func _update_tracks(value) -> void:
	var low_health = owner.low_health
	
	if not low_health and value <= playerStats.max_health / 2:
		audioControl.current_normal_BGM = audioControl.normal_low_hp_BGM
		audioControl.current_combat_BGM = audioControl.combat_low_hp_BGM
		
		low_health = true
		
		select_audio_track()
			
	if low_health:
		if value > playerStats.max_health / 2:
			audioControl.current_normal_BGM = audioControl.normal_BGM
			audioControl.current_combat_BGM = audioControl.combat_BGM
			
			select_audio_track()


func select_audio_track() -> void:
	if owner.has_combat:
		play_audio(audioControl.current_combat_BGM)
	
	else:
		play_audio(audioControl.current_normal_BGM)
		
		
func play_audio(track :Resource) -> void:
	stream = track
	play()
		
