extends Area2D

#export var collision_shape :Shape2D setget set_collision_shape

var player = null


func can_see_player():
	return player != null
	
	
func _on_PlayerDetection_body_entered(body):
	player = body


func _on_PlayerDetection_body_exited(body):
	player = null

