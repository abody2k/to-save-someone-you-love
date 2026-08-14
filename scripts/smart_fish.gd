extends CharacterBody3D


var target : CharacterBody3D

func _ready():
	
	target = get_tree().get_first_node_in_group("player")
	
	
	

func _physics_process(delta):
	
	look_at(target.global_position)
	velocity = 10 * -global_basis.z
	var obj = move_and_collide(velocity * delta)
	
	if obj:
		
		if obj.get_collider():
			#TODO play attack animation and at the end of it make the player reload the scene
			pass
		pass
		
	
