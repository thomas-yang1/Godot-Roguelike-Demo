# Claw
extends Node2D

export var animation_speed = 1.3
export var hook_speed :float = 3.3
export var sprite_speed :float = 1

onready var body = $Body
onready var bodyCollision = $Body/CollisionShape2D
onready var sprite = $Sprite

var has_extended = false
var has_interrupted = false
var has_finished = false

var x = 811
var w = 36
var max_sprite_range = Rect2(2, 5, 845, 33)
var min_sprite_range = Rect2(811, 5, 36, 33)

var target_position = null


func _ready():
	set_process(false)

		
# warning-ignore:unused_argument
func _process(delta):
	if not has_interrupted:
		if not has_extended:
			self.show()
			bodyCollision.set_deferred("disabled", false)
			extend_claw_animation()
		
		else:
			bodyCollision.set_deferred("disabled", true)
			reverse_claw_animation()
			
	else:
		bodyCollision.set_deferred("disabled", true)
		interrupted_claw_animation()
	
	
	
func _on_Body_body_entered(_body):
	target_position = _body.global_position
	has_extended = true
	has_interrupted = true


func extend_claw_animation() -> void:
	if sprite.region_rect.encloses(max_sprite_range):
		has_extended = true
		
	else:
		update_position(Vector2.RIGHT)
		x -= animation_speed
		w += animation_speed
		sprite.region_rect = Rect2(x, 5, w, 33)


func reverse_claw_animation() -> void:
	if sprite.region_rect.is_equal_approx(min_sprite_range):
		has_finished = true
		set_process(false)
		
	else:
		update_position(Vector2.LEFT)
		x += animation_speed 
		w -= animation_speed 
		sprite.region_rect = Rect2(x, 5, w, 33)


func interrupted_claw_animation() -> void:
	owner.audio.stream = owner.chain_hit_sound
	owner.audio.play()
	
	x += animation_speed
	w -= animation_speed
	
	sprite.position += Vector2.RIGHT * sprite_speed

	
	if sprite.region_rect.is_equal_approx(min_sprite_range):
		has_finished = true
		set_process(false)
		
	else:
		sprite.region_rect = Rect2(x, 5, w, 33)
		

func update_position(_direction):
	sprite.position += _direction * sprite_speed
	body.position += _direction * hook_speed
	

func reset() -> void:
	self.hide()
	has_finished = false
	has_extended = false
	has_interrupted = false
	target_position = null
	sprite.region_rect = min_sprite_range
	sprite.position = Vector2.ZERO
	body.position = Vector2.ZERO
	x = 811
	w = 36

