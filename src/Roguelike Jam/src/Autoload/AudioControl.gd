extends Node

export var volume_adjustment :float = 10

onready var _anim_player := $AnimationPlayer

onready var _theme_1 := $Theme_1
onready var _theme_2 := $Theme_2
onready var _combat_1 := $Combat_1
onready var _combat_2 := $Combat_2

export var theme_normal :AudioStream
export var theme_low :AudioStream
export var combat_normal :AudioStream
export var combat_low :AudioStream
export var death_normal :AudioStream


func _set_theme_track() -> void:
# warning-ignore:integer_division
	if PlayerStats.health >= PlayerStats.max_health / 2:
		crossfade_to(_theme_1, _theme_2, theme_normal)
	
	else:
		crossfade_to(_theme_1, _theme_2, theme_low)


func _set_death_track() -> void:
	_stop_combat_track()
	crossfade_to(_theme_1, _theme_2, death_normal)
	
	
func _start_combat_track() -> void:
	_adjust_theme_volume(true)
	
# warning-ignore:integer_division
	if PlayerStats.health >= PlayerStats.max_health / 2:
		crossfade_to(_combat_1, _combat_2, combat_normal)

	else:
		crossfade_to(_combat_1, _combat_2, combat_low)


func _stop_combat_track() -> void:
	_adjust_theme_volume(false)
	
	_combat_1.stop()
	_combat_2.stop()


func _adjust_theme_volume(value: bool) -> void:
	if value:
		_theme_1.volume_db -= volume_adjustment
		_theme_2.volume_db -= volume_adjustment
	
	else:
		_theme_1.volume_db += volume_adjustment
		_theme_2.volume_db += volume_adjustment


func crossfade_to(_track1, _track2, audio_stream: AudioStream) -> void:
	if _track1.playing and _track2.playing:
		return

	if _track2.playing:
		_track1.stream = audio_stream
		_track1.play(get_audio_position())
		_anim_player.play("FadeToTrack1")
		
	else:
		_track2.stream = audio_stream
		_track2.play(get_audio_position())
		_anim_player.play("FadeToTrack2")


func get_audio_position() -> float:
	if _theme_1.playing:
		return _theme_1.get_playback_position()
		
	else:
		return _theme_2.get_playback_position()
	
