extends Area2D

signal unlock
signal lock


func _on_Platform_body_entered(body: KinematicBody2D) -> void:
	if not body is Box:
		return
	emit_signal("unlock", 1)
	
	
func _on_Platform_body_exited(body: KinematicBody2D) -> void:
	if not body is Box:
		return
	emit_signal("lock", -1)
