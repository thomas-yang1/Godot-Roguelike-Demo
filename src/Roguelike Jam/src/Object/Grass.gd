extends Node2D

export (PackedScene) var effect

# warning-ignore:unused_argument
func _on_Grass_area_entered(area):
	var effectInstance = effect.instance()
	get_parent().add_child(effectInstance)
	effectInstance.global_position = global_position
	
	queue_free()
	
