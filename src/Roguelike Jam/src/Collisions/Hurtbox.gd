extends Area2D

export var effect :PackedScene

var invincible = false setget set_invincible
onready var timer = $Timer

signal invincibility_started
signal invincibility_ended


func set_invincible(value) -> void:
	invincible = value
	
	if invincible:
		emit_signal("invincibility_started")
		
	else:
		emit_signal("invincibility_ended")


func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)
	
	
# warning-ignore:unused_argument
func _on_Hurtbox_area_entered(area):
	var instanced = effect.instance()
	owner.add_child(instanced)
	instanced.global_position = global_position


func create_effect():
	var instanced = effect.instance()
	var main = get_tree().current_scene
	main.add_child(instanced)
	instanced.global_position = global_position
	
		
func _on_Timer_timeout():
	self.invincible = false


func _on_Hurtbox_invincibility_ended():
	set_deferred("monitorable", false)


func _on_Hurtbox_invincibility_started():
	set_deferred("monitorable", true)
	
