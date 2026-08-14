extends Area3D

@export var bubble_speed = 10.0

var small_bubble= true


func _physics_process(delta):
	
	global_position += (-global_basis.z) * bubble_speed * delta


func _on_body_entered(body):
	
	if not small_bubble and body.is_in_group("fish"):
		body.be_contained_by(self)
		look_at(global_position + ((Vector3.UP) * 100))
		
		
	queue_free()
	#TODO make sound
	
