extends StaticBody2D

onready var collision = $CollisionShape2D
onready var platforms = $Platforms

onready var lock_required :int = platforms.get_child_count()

var current_lock :int = 0


func _ready() -> void:
	for child in platforms.get_children():
		child.connect("lock", self, "_on_Platform_unlocked")
		child.connect("unlock", self, "_on_Platform_unlocked")
	

func _on_Platform_unlocked(key: int) -> void:
	current_lock += key
	
	if current_lock >= lock_required:
		self.hide()
		collision.set_deferred("disabled", true)
	
	else:
		self.show()
		collision.set_deferred("disabled", false)
