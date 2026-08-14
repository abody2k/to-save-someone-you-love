extends CharacterBody3D


var can_move = true
var slow_down_factor : float = 0.0


func _ready():
	pass
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

@export var speed = 20.0
	

func _physics_process(delta):
	
	if not can_move:
		return
		
		
	if Input.is_action_pressed("swim"):
		print("SWIMMING")
		velocity =(  - $shape.global_basis.y) * speed
		slow_down_factor = 0.0
	else:
		slow_down_factor+=delta
		slow_down_factor = clampf(slow_down_factor,0.0,1.0)
		velocity = lerp(velocity, Vector3.DOWN * speed,slow_down_factor)
		
	
	#var quat = Quaternion.from_euler(Vector3($shape.global_rotation.x,$shape.global_rotation.y,$shape.global_rotation.z))
	
	#$shape.quaternion = quat
	var quat_left_right = Quaternion(Vector3.UP,Input.get_axis("left","right") * delta)
	var quat_up_down = Quaternion(Vector3.RIGHT,Input.get_axis("forward","backward") * delta)
	$shape.quaternion = quat_left_right * quat_up_down * $shape.quaternion
	#$shape.quaternion = $shape.quaternion * quat_up_down
	#$shape.rotate_z(Input.get_axis("left","right") * delta)
	#$shape.rotate_x(Input.get_axis("forward","backward") * delta)
	print(velocity)
	move_and_slide()


func _input(event):
	
	if event is InputEventMouseMotion:
		var x : InputEventMouseMotion = event

		#rotate_x(clampf(x.screen_relative.y,-1,1) * 1 * get_physics_process_delta_time())
		
		
		#$arm.quaternion = Quaternion(Vector3.UP,get_physics_process_delta_time() * clamp(x.screen_relative.y,-1,1) * 10) * Quaternion(Vector3.FORWARD,get_physics_process_delta_time() * clamp(x.screen_relative.x,-1,1) * 10) * $arm.quaternion
		$arm.rotate_y(get_physics_process_delta_time() * clamp(x.screen_relative.x,-1,1) * 10)
		
