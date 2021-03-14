extends Event

onready var box_required :int = get_child_count() / 2
var current_box :int = 0


func _on_BoxTarget_body_entered(body):
	if not body is Box:
		return
		
	current_box += 1
	
	if current_box >= box_required:
		emit_signal("unlock")


func _on_BoxTarget_body_exited(body):
	if not body is Box:
		return
		
	current_box -= 1
