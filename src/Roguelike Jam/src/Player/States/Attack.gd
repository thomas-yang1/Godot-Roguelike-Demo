# Attack state
extends State

var velocity = Vector2.ZERO

# warning-ignore:unused_argument
func physics_process(delta) -> void:
	Events.emit_signal("player_moved", owner)
	
		
# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:	
	owner.animationState.travel("Attack")

	
func exit() -> void:
	return

	
func _on_Attack_animation_finished() -> void:
	_state_machine.transition_to("Move/Idle")
