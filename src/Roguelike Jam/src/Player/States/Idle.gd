# Idle
tool
extends State


func unhandled_input(event: InputEvent) -> void:
	var move = get_parent()
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	var move: = get_parent()
	owner.animationState.travel("Idle")
	
	if move.get_move_direction() != Vector2.ZERO:
		_state_machine.transition_to("Move/Run")
		
	else:
		move.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	var move = get_parent()
	move.enter(msg)
	
	move.max_speed = move.max_speed_default
	
	move.velocity = Vector2.ZERO
	

func exit() -> void:
	get_parent().exit()
