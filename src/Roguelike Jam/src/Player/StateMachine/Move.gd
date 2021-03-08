extends Node

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var FRICTION = 500

var velocity = Vector2.ZERO

func _enter_state(delta) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		get_parent().roll_vector = input_vector
		get_parent().player_dir = input_vector
		
		owner.animationTree.set("parameters/Idle/blend_position", input_vector)
		owner.animationTree.set("parameters/Run/blend_position", input_vector)
		owner.animationTree.set("parameters/Attack/blend_position", input_vector)
		owner.animationTree.set("parameters/Roll/blend_position", input_vector)
		
		owner.animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		owner.animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = owner.move_and_slide(velocity)


func _exit_state(delta) -> void:
	pass
