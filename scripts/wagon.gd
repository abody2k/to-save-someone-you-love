extends CharacterBody3D


var acc : float = 0.0:
	set(value):
		acc = clampf(value,0.0,100.0)

func wagon_moved():
	acc += get_physics_process_delta_time() * 20
	
func _on_gate_gate_opened():
	wagon_moved()


func _on_gate_2_gate_opened():
	wagon_moved()
	
var go_down = false

func _physics_process(delta):
	acc -=delta
	
	if not go_down:
		velocity = acc*-basis.z
	else:
		velocity = Vector3.DOWN
		
	move_and_slide()
