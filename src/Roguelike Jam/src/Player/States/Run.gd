extends State
"""
Horizontal movement on the ground.
Delegates movement to its parent Move state and extends it
with state transitions
"""


func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	var move: = get_parent()
	
	if move.get_move_direction() == Vector2.ZERO:
		_state_machine.transition_to("Move/Idle")
	
	elif owner.get_slide_count() >0:
		if owner.get_slide_collision(0).collider as Box:
			_state_machine.transition_to("Move/Push")
		
	owner.animationState.travel("Run")
	move.physics_process(delta)
		

func enter(msg: Dictionary = {}) -> void:
	get_parent().enter(msg)


func exit() -> void:
	get_parent().exit()
