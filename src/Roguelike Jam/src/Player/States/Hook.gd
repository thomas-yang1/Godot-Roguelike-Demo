# Hook state
extends State

export var hook_speed := 50
var velocity = Vector2.ZERO

# warning-ignore:unused_argument
func physics_process(delta) -> void:
	
	var direction = owner.global_position.direction_to(owner.hookDetect.get_collision_point())
	velocity = direction * hook_speed
	velocity = owner.move_and_slide(velocity)
		
	if owner.get_slide_count() >0:
		Events.emit_signal("player_moved", owner)
		_state_machine.transition_to("Move/Idle")
		

# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:	
#	owner.collision.set_deferred("disabled", true)
	return

func exit() -> void:
#	owner.collision.set_deferred("disabled", false)
	return
	
func _on_Attack_animation_finished() -> void:
	_state_machine.transition_to("Move/Idle")
