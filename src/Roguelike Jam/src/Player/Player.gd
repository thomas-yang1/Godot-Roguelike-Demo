extends KinematicBody2D
class_name Player

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

onready var hitboxPivot = $HitboxPivot
onready var hookDetect = $HitboxPivot/HookDetect
onready var collision = $CollisionShape2D

onready var stateLabel = $StateLabel
onready var hurtbox = $Hurtbox
onready var stats = PlayerStats

var can_hook = false


func _ready() -> void:
	animationTree.active = true
	stats.connect("no_health", self, "queue_free")


func _process(_delta: float) -> void:
	if hookDetect.is_colliding():
		can_hook = true
		
	else:
		can_hook = false
	
	
func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	hurtbox.create_effect()
	hurtbox.start_invincibility(0.5)
