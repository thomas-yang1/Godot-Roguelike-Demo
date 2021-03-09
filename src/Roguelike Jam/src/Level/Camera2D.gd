extends Camera2D

onready var viewport = get_viewport().get_visible_rect().size

func _process(delta) -> void:
	var pos = get_node("../Player").global_position
	var x = floor(pos.x / viewport.x) * viewport.x
	var y = floor(pos.y / viewport.y) * viewport.y
	global_position = Vector2(x, y)
