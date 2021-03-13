# Attack state
extends State

var velocity = Vector2.ZERO
var can_move = false


# warning-ignore:unused_argument
func physics_process(delta) -> void:
	if get_move_direction() != Vector2.ZERO and can_move:
		_state_machine.transition_to("Move/Idle")
		
	yield(owner.animationPlayer, "animation_finished")
	_state_machine.transition_to("Move/Idle")


# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:
	can_move = false
	owner.animationPlayer.play("Attack")
	
	
func exit() -> void:
	return
	

func set_can_move():
	can_move = true


func get_move_direction() -> Vector2:
	var move_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	return move_direction.normalized()
