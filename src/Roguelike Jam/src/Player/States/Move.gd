extends State
"""
Parent state that abstracts and handles basic movement
Move-related children states can delegate movement to it, or use its utility functions
"""

export var max_speed_default := 500
export var acceleration_default := 300
export var move_direction := Vector2.LEFT 

var max_speed := max_speed_default
var acceleration := acceleration_default
var velocity := Vector2.ZERO


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		_state_machine.transition_to("Attack")
		
	elif event.is_action_pressed("claw"):
		_state_machine.transition_to("Claw")
	
	
# warning-ignore:unused_argument
func physics_process(delta: float) -> void:
	velocity = calculate_velocity(velocity, get_move_direction())
	velocity = owner.move_and_slide(velocity)
	
	
	if velocity.length_squared() != 0:
		Events.emit_signal("player_moved", owner)


	if owner.get_slide_count() >0:
		_state_machine.transition_to("Push")
		

# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:
	# connect states via owner
	pass
	
	
func exit() -> void:
	# disconnect states via owner
	velocity = Vector2.ZERO
#	pass
	

func calculate_velocity(old_velocity: Vector2, get_move_direction: Vector2) -> Vector2:
	var new_velocity = old_velocity
	
	if move_direction != Vector2.ZERO:
		new_velocity = new_velocity.move_toward(get_move_direction * max_speed, acceleration)
		calculate_hitbox_pivot()
	
	return new_velocity
		

func get_move_direction() -> Vector2:
	move_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	return move_direction.normalized()


func calculate_hitbox_pivot():
	var hitboxPivot = owner.hitboxPivot
	var hitbox = owner.hitbox
	var sprite = owner.sprite
	match move_direction:
		Vector2.LEFT:
			sprite.scale.x = -1
			hitboxPivot.scale.x = -1
			owner.player_direction = Vector2.LEFT
			hitbox.knockback_vector = Vector2.LEFT

		Vector2.RIGHT:
			sprite.scale.x = 1
			hitboxPivot.scale.x = 1
			owner.player_direction = Vector2.RIGHT
			hitbox.knockback_vector = Vector2.RIGHT
