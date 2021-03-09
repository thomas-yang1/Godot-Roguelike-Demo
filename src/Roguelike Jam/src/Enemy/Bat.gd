extends KinematicBody2D

onready var stats = $Stats

export (PackedScene) var effect

export var acceleration = 200
export var friction = 200
export var max_speed = 200

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO

enum {IDLE, WANDER, CHASE}
var state = IDLE

onready var playerDetection = $PlayerDetection
onready var sprite = $Sprite
onready var hurtbox = $Hurtbox

signal player_detected
signal player_undetected


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
			seek_player()
			
		WANDER:
			pass
			
		CHASE:
			var player = playerDetection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
				
			else:
				state = IDLE
				
			sprite.flip_h = velocity.x < 0
			
	velocity = move_and_slide(velocity)


func seek_player():
	if playerDetection.can_see_player():
		emit_signal("player_detected")
		state = CHASE
	


func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	knockback = area.knockback_vector * 120
	hurtbox.create_effect()


func _on_Stats_no_health():
	var effectInstance = effect.instance()
	effectInstance.position = self.position
	owner.add_child(effectInstance)
	
	queue_free()

