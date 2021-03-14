# Push State
extends State

export var push_speed = 50


func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	var move = get_parent()
	
	if owner.get_slide_count() >= 1:
		check_box_collision(move.move_direction)
		owner.animationPlayer.play("Push")
	
	else:
		owner.animationPlayer.stop()
		_state_machine.transition_to("Move/Idle")
		
	move.physics_process(delta)


func check_box_collision(motion: Vector2) -> void:
	if abs(motion.x) + abs(motion.y) > 1:
		return
		
	var box := owner.get_slide_collision(0).collider as Box
	
	if box:
		box.push(push_speed * motion)
		

func enter(msg: Dictionary = {}) -> void:
	var move = get_parent()
	move.enter(msg)


func exit() -> void:
	var move = get_parent()
	move.max_speed = move.max_speed_default
	move.exit()
