# Claw
extends Node2D

var velocity = Vector2.ZERO

export var animation_speed = 1.3
export var hook_speed :float = 3.3
export var sprite_speed :float = 1

onready var body = $Body
onready var bodyCollision = $Body/CollisionShape2D
onready var sprite = $Sprite

var has_extended = false
var has_interrupted = false
var has_finished = false

var x = 156
var w = 35


func _ready():
	set_process(false)

		
func _process(delta):
	if not has_interrupted:
		if not has_extended:
			self.show()
			has_finished = false
			bodyCollision.set_deferred("disabled", false)
			extend_claw_animation()
		
		else:
			bodyCollision.set_deferred("disabled", true)
			reverse_claw_animation()
			
	else:
		bodyCollision.set_deferred("disabled", true)
		interrupted_claw_animation()
	
	
	
func _on_Body_body_entered(body):
	has_extended = true
	has_interrupted = true


func extend_claw_animation() -> void:
	if not has_extended:
		x -= animation_speed
		w += animation_speed
		
		update_position(Vector2.RIGHT)
		
		if sprite.region_rect.encloses(Rect2(1, 5, 190, 33)):
			has_extended = true
			
		else:
			sprite.region_rect = Rect2(x, 5, w, 33)


func reverse_claw_animation() -> void:
	x += animation_speed
	w -= animation_speed
	
	update_position(Vector2.LEFT)
	
	if sprite.region_rect.is_equal_approx(Rect2(156, 5, 35, 33)):
		has_finished = true
		reset()
		set_process(false)
		
	else:
		sprite.region_rect = Rect2(x, 5, w, 33)


func interrupted_claw_animation() -> void:
	x += animation_speed
	w -= animation_speed
	
	sprite.position += Vector2.RIGHT * sprite_speed
	
	if sprite.region_rect.is_equal_approx(Rect2(156, 5, 35, 33)):
		has_finished = true
		reset()
		set_process(false)
		
	else:
		sprite.region_rect = Rect2(x, 5, w, 33)
		

func update_position(_direction):
	sprite.position += _direction * sprite_speed
	body.position += _direction * hook_speed
	

func reset() -> void:
	self.hide()
	has_extended = false
	has_interrupted = false
	sprite.region_rect = Rect2(156, 5, 35, 33)
	sprite.position = Vector2.ZERO
	body.position = Vector2.ZERO
	x = 156
	w = 35

