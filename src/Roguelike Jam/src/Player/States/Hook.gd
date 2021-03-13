# Hook state
extends State

var velocity = Vector2.ZERO
var claw :Node2D


func physics_process(delta) -> void:
	if claw != null:
		if claw.has_interrupted and not claw.has_finished:
			owner.move_and_slide(Vector2(claw.scale.x, 0) * 220)
			
		elif claw.has_finished:
			claw.has_finished = false
			_state_machine.transition_to("Move/Run")
	
	
# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:
	owner.animationPlayer.play("Idle")
	claw = owner.claw
	claw.set_process(true)


func exit() -> void:
	return
