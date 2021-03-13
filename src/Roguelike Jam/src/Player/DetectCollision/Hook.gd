extends Area2D


func _on_Hook_body_entered(body):
	owner.can_hook = true
	owner.hook_target = body

# warning-ignore:unused_argument
func _on_Hook_body_exited(body):
	owner.can_hook = false
