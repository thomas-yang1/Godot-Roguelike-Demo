extends KinematicBody2D
class_name Box

var vector = Vector2.ZERO

func push(velocity: Vector2) -> void:
# warning-ignore:return_value_discarded
	move_and_slide(velocity, Vector2())
