extends RayCast3D


func _physics_process(delta: float) -> void:
	
	if is_colliding():
		print("Detecting Something")
