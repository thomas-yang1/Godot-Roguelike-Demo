extends KinematicBody2D
class_name Player

var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var hitboxPivot = $HitboxPivot
onready var stateLabel = $StateLabel

onready var move = $StateMachine/Move

var can_hook = false

#onready var hurtbox = $Hurtbox
#onready var label = $Label

func _ready() -> void:
	animationTree.active = true
	stats.connect("no_health", self, "queue_free")


#func hook_state():
#	calculate_hook_position()
#
#	hook_target = null
##	animationState.travel("hook")
#	state = MOVE
#
#
#func calculate_hook_position() -> void:
#	var target = hook_target.position - self.position
#	self.position = self.position + target / 1.8
#
#
#
#func attack_animation_finished():
#	state = MOVE
#
#
#func _on_Hurtbox_area_entered(area):
#	stats.health -= 1
#	hurtbox.create_effect()
#	hurtbox.start_invincibility(0.5)
