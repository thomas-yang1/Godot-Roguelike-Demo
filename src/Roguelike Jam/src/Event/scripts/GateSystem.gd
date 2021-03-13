extends StaticBody2D

#export var level :PackedScene setget set_level

var levels = [
	"res://src/Level/TimerLevel.tscn",
	"res://src/Level/EnemyLevel.tscn",
	"res://src/Level/BoxLevel.tscn"]
	

#func set_level(value) -> void:
#	var instanced = value.instance()
#	add_child(instanced)
	

func _on_Unlock_gate() -> void:
	set_gate_unlocked()
	

func set_gate_unlocked() -> void:
	for gate in get_children():
		if gate.is_in_group("Gate"):
			gate.set_deferred("disabled", true)
			gate.hide()


func _on_Exit_body_entered(_body) -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(levels[get_random_level()])



func get_random_level() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	return rng.randi_range(0, levels.size() - 1)
