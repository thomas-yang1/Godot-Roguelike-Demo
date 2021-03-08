extends Area2D
export var spawn_time = 0.4


func _ready() -> void:
	$Timer.wait_time = spawn_time
	$Timer.start()
	
	
func _on_Timer_timeout():
	queue_free()
