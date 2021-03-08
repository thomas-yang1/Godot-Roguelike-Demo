extends Node

export var meele_attack :PackedScene 
var meele_instanced :Area2D

func _enter_state(delta):
	owner.animationState.travel("Attack")


func _instance_attack():
	var spawn_correction = 27
	meele_instanced = meele_attack.instance()
	meele_instanced.position = owner.position + get_parent().player_dir * spawn_correction
	add_child(meele_instanced)

	
func _exit_state():
	var states = get_parent()
	states.state = states.MOVE
