extends Node2D

export var enemy :PackedScene
export var enemy_count := 3
var enemy_died_count :int

var spawn_locations :Array

signal enter_combat
signal exit_combat


func _ready() -> void:
	connect("enter_combat", owner, "_on_Enter_combat")
	connect("exit_combat", owner, "_on_Exit_combat")
	
	for child in get_children():
		if child.is_in_group("spawn_location"):
			spawn_locations.append(child)

	
func _on_Timer_timeout() -> void:
	emit_signal("enter_combat")
	
	for count in enemy_count:
		var spawn_int = get_random_spawn_location()
		var spawn_location = spawn_locations[spawn_int]
		
		spawn_locations.remove(spawn_int)
		
		spawn_enemy(spawn_location)


func get_random_spawn_location() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	return rng.randi_range(0, spawn_locations.size() - 1)


func on_Update_enemy_counter():
	enemy_died_count += 1
	
	if enemy_died_count >= enemy_count:
		emit_signal("exit_combat")
		emit_signal("unlock")

func spawn_enemy(spawn_location) -> void:
	var enemy_instance = enemy.instance()
	enemy_instance.find_node("Stats").connect("no_health", self, "on_Update_enemy_counter")
	spawn_location.add_child(enemy_instance)
	

	


