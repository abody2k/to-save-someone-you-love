extends Area3D

@export var bubble_speed = 10.0

var small_bubble= true
var original_pos : Vector3:
	set(value):
		original_pos = value
		global_position = original_pos


func _ready():
	global_position = original_pos
	
	print(original_pos)
	
	if not small_bubble:
		get_tree().create_tween().tween_property(self,"scale",Vector3.ONE,0.5)
	else:
		$shape.scale = Vector3.ONE * 0.16

func _physics_process(delta):
	pass
	global_position += (-global_basis.z) * bubble_speed * delta


func _on_body_entered(body):
	
	if not small_bubble and body.is_in_group("fish"):
		body.be_contained_by(self)
		look_at(global_position + ((Vector3.UP) * 100))
		return
		
	queue_free()
	#TODO make sound
	


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
