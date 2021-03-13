extends Node2D
class_name Event

# warning-ignore:unused_signal
signal unlock


func _ready():
# warning-ignore:return_value_discarded
	connect("unlock", get_parent(), "_on_Unlock_gate")
