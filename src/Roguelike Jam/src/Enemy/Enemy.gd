extends KinematicBody2D
class_name Enemy

onready var stats = $Stats

onready var deathEffect :PackedScene = preload("res://src/Effect/DeathEffect.tscn")

export var acceleration = 10
export var friction = 10
export var max_speed = 50
export var knockback_force := 30

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO

enum {IDLE, WANDER, CHASE}
var state

onready var playerDetection = $PlayerDetection
onready var sprite = $Sprite
onready var hurtbox = $Hurtbox
onready var animationPlayer = $AnimationPlayer
onready var hurtAnim = $HurtAnimationPlayer
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
	
	
func has_player() -> bool:
	if playerDetection.can_see_player():
		return true
		
	else:
		return false
	

func _on_Hurtbox_area_entered(hitbox):
	stats.health -= hitbox.damage
	knockback = hitbox.knockback_vector * knockback_force

	hurtAnim.play("Hurt")
	hurtbox.create_effect()


func _on_Stats_no_health():
	var deathEffectInstance = deathEffect.instance()
	deathEffectInstance.position = self.position
	owner.add_child(deathEffectInstance)
	queue_free()


#func pick_random_state(state_list):
#	state_list.shuffle()
#	return state_list.pop_front()
