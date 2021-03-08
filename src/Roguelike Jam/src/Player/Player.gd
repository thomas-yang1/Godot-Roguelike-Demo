extends KinematicBody2D

export var ACCELRATION = 500
export var FRICTION = 500
export var hook_SPEED = 80
export var MAX_SPEED = 80

enum {MOVE, HOOK, ATTACK}

var state = MOVE
var velocity = Vector2()
var player_dir = Vector2.LEFT
var hook_target = null
var can_hook = false

var stats = PlayerStats

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var hurtbox = $Hurtbox


func _ready():
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true


func _process(delta):
	match state:
		MOVE:
			move_state(delta)
		HOOK:
			hook_state()
		ATTACK:
			attack_state()
			

func move_state(delta):
	move()
	var input_vector = Vector2.ZERO.normalized()
	
	input_vector.x = Input.get_action_strength(("right")) - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength(("down")) - Input.get_action_strength("up")

	if input_vector != Vector2.ZERO:
		player_dir = input_vector
		$HitboxPivot/Melee.knockback_vector = input_vector
		
		animationTree.set("parameters/Idle/blend_position", input_vector)		
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)

		animationState.travel("Run")
		
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELRATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	if Input.is_action_just_pressed("hook") and hook_target:
		state = HOOK
		
	if Input.is_action_just_pressed("attack"):
		state = ATTACK


func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	

func move():
	velocity = move_and_slide(velocity)
	update_hitbox_rotation()
	

func update_hitbox_rotation():
	match player_dir:
		Vector2.UP:
			$HitboxPivot.rotation_degrees = -90
			
		Vector2.DOWN:
			$HitboxPivot.rotation_degrees = 90
			
		Vector2.LEFT:
			$HitboxPivot.rotation_degrees = 180
			
		Vector2.RIGHT:
			$HitboxPivot.rotation_degrees = 0
	

func hook_state():
	calculate_hook_position()

	hook_target = null
#	animationState.travel("hook")
	state = MOVE


func calculate_hook_position() -> void:
	var target = hook_target.position - self.position
	self.position = self.position + target / 1.8

#func hook_animation_finished():
#	velocity = velocity * 0.5
#	state = MOVE

	
func attack_animation_finished():
	state = MOVE


func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	hurtbox.create_effect()
	hurtbox.start_invincibility(0.5)
