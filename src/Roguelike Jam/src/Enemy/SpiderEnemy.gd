extends Enemy

onready var raycast = $RayCast2D


func _ready() -> void:
	state = WANDER


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		WANDER:
			if has_player():
				if raycast.is_colliding():
					state = ATTACK
					
				else:
					state = CHASE
			
			accelerate_towards_point(wanderController.target_position, delta)

		CHASE:
			var player = playerDetection.player
	
			if player != null:
				animationPlayer.play("Run")
				accelerate_towards_point(player.global_position, delta)
				
			else:
				state = WANDER
				
			sprite.flip_h = velocity.x < 0
		
		ATTACK:
			print("Shoot")
			state = WANDER
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 50
	
	velocity = move_and_slide(velocity)


func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	sprite.flip_h = velocity.x < 0
	
	
	
