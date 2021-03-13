extends Event
class_name EnemySpawner

export var enemy :PackedScene
export var total_enemy_count := 3
var enemy_died_count :int

var zones :Array
var current_zones :Array = zones

# warning-ignore:unused_signal
signal enter_combat
# warning-ignore:unused_signal
signal exit_combat


func _ready() -> void:
	var main = get_tree().root.get_child_count() - 1
	main = get_tree().root.get_child(main)
	
# warning-ignore:return_value_discarded
	connect("enter_combat", main, "_on_Enter_combat")
# warning-ignore:return_value_discarded
	connect("exit_combat", main, "_on_Exit_combat")
	
	for child in get_children():
		if child.is_in_group("Zone"):
			zones.append(child)


func spawn_enemies() -> void:
	current_zones = zones.duplicate(true)
	
	for count in total_enemy_count:
		var zone = get_random(current_zones)
		var random_location = rand_range(0, zone.get_child_count() - 1)
		var spawn_location = zone.get_child(random_location)
	
		instance_enemy(spawn_location)
	

func instance_enemy(spawn_location) -> void:
	var enemy_instance = enemy.instance()
	spawn_location.add_child(enemy_instance)
	enemy_instance.find_node("Stats").connect("no_health", self, "on_Update_enemy_counter")


func get_random(array: Array) -> Node2D:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var random_array = rng.randi_range(0, array.size() -1)
	var _array = array[random_array]
	
	array.remove(random_array)
	
	return _array


