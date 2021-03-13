extends KinematicBody2D


func _process(delta) -> void:
	if get_slide_count() >0:
		print("Ya")
		$LightningBeam.shoot()
