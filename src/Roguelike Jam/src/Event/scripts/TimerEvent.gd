extends EnemySpawner

onready var label = $Label
onready var gateTimer = $GateUnlockTimer
onready var spawnTimer = $EnemySpawnTimer

var has_combat = false

# warning-ignore:unused_argument
func _process(delta) -> void:
	label.text = str(int(gateTimer.time_left))
	
		
func _on_EnemySpawnTimer_timeout():
	if has_combat == false:
		emit_signal("enter_combat")
		has_combat = true
	
	spawn_enemies()


func _on_GateUnlockTimer_timeout():
	emit_signal("unlock")
	emit_signal("exit_combat")
	spawnTimer.stop()
	
	remove_enemies()


func remove_enemies():
	for child in get_children():
		if child.is_in_group("Zone"):
			child.queue_free()


func on_Update_enemy_counter() -> void:
	return
#	enemy_died_count += 1
#
#	if enemy_died_count >= total_enemy_count:
#		emit_signal("unlock")
#		emit_signal("exit_combat")
