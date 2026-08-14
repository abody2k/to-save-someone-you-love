extends Area3D



func _physics_process(delta):
	
	global_position += -global_basis.z
