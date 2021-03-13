extends Node2D

export var wander_range := 68

onready var start_position = global_position
onready var target_position = global_position

onready var timer = $Timer


func _ready() -> void:
	update_target_position()
	
	
func update_target_position():
	var target_vector = Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
	target_position = start_position + target_vector


func start_wander_time(duration) -> void:
	timer.start(duration)
	

func _on_Timer_timeout():
	update_target_position()
