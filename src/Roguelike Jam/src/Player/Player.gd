extends KinematicBody2D
class_name Player

onready var animationPlayer = $AnimationPlayer
onready var audio = $AudioStreamPlayer
onready var audiostream2 = $AudioStreamPlayer2

onready var hitboxPivot = $HitboxPivot
onready var hitbox = $HitboxPivot/Hitbox

onready var hookDetect = $HitboxPivot/HookDetect
onready var collision = $CollisionShape2D

onready var stateLabel = $StateLabel
onready var hurtbox = $Hurtbox
onready var stats = PlayerStats

onready var sprite = $Sprite
onready var claw = $HitboxPivot/Claw

export var chain_sound :AudioStream
export var chain_hit_sound :AudioStream
export var box_push_sound :AudioStream


var player_direction := Vector2.RIGHT
var can_hook = false


func _ready() -> void:
	randomize()
	stats.connect("no_health", self, "_on_Player_died")


func _process(_delta: float) -> void:
	if hookDetect.is_colliding():
		can_hook = true
		
	else:
		can_hook = false
	
	
func _on_Hurtbox_area_entered(_hitbox):
	stats.health -= _hitbox.damage
	hurtbox.create_effect()
	audiostream2.play()
	hurtbox.start_invincibility(1)


func _on_Player_died():
	pass
