extends CharacterBody3D


var target : CharacterBody3D

func _ready():
	
	target = get_tree().get_first_node_in_group("player")
	
	
var cant_move = false
func be_contained_by(obj):
	reparent(obj)
	cant_move = true
	
	
func _physics_process(delta):
	if cant_move:
		return
		
		
	look_at(target.global_position)
	velocity = 10 * -global_basis.z
	var obj = move_and_collide(velocity * delta)
	
	if obj:
		
		if obj.get_collider():
			#TODO play attack animation and at the end of it make the player reload the scene
			pass
		pass
		
	
