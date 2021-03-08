extends Node

const ROLL_SPEED = 80
var velocity 


func _enter_state(delta) -> void:
	velocity = get_parent().player_dir * ROLL_SPEED
	owner.move_and_slide(velocity)
#	_exit_state()
	
	
func _exit_state() -> void:
	velocity / 2
	var states = get_parent()
	states.state = states.MOVE
	
