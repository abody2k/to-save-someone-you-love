extends CharacterBody3D


var can_move = false
var slow_down_factor : float = 0.0


func _physics_process(delta):
	
	if not can_move:
		return
		
		
	if Input.is_action_pressed("forward"):
		velocity = -basis.z - basis.y
		slow_down_factor = 0.0
	else:
		slow_down_factor+=delta
		slow_down_factor = clampf(slow_down_factor,0.0,1.0)
		velocity = lerp(velocity,- basis.y,slow_down_factor)
		
		
	move_and_slide()
