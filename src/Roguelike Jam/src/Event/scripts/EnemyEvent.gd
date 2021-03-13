extends EnemySpawner

func _on_Timer_timeout() -> void:
	emit_signal("enter_combat")
	
	spawn_enemies()

func on_Update_enemy_counter() -> void:
	enemy_died_count += 1
	
	if enemy_died_count >= total_enemy_count:
		emit_signal("unlock")
		emit_signal("exit_combat")
