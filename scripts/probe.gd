extends CharacterBody3D


func _physics_process(delta):
	
	velocity =-10 * global_basis.z
	var obj = move_and_collide(velocity * delta)
	
	if obj:
		
		if obj.get_collider().is_in_group("player"):
			obj.get_collider().take_hit()
		queue_free()
	
