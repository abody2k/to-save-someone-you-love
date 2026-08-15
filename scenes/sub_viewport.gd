extends Node3D

var dialogs = [
	["hola",null,1.0],
	["yes",null,1.0],
	["no",null,1.0],
	["ohh",null,1.0],
	["ffff",null,1.0],
	["",null,1.0],
	["",null,1.0],
	["",null,1.0],
	["",null,1.0],
	["",null,1.0],
	["",null,1.0],
	["",null,1.0],
	]
	
	
func _unhandled_input(event):
	$SubViewport.push_input(event)


func _on_final_body_entered(body):
	
	if body.is_in_group("player"):
		print("started animation")
		$SubViewport/AnimationPlayer.play("start_dialog")
		$SubViewport/final.queue_free()

var can_interract = false
var current_dialog = 0

func run_next_dialog():
	var dialog = dialogs[current_dialog][0]
	if dialogs[current_dialog][1]:
		dialogs[current_dialog][0].call()
	var tween = create_tween()
	tween.tween_property($CanvasLayer/Control/RichTextLabel,"text","",0.25)
	await tween.tween_property($CanvasLayer/Control/RichTextLabel,"text",dialog,2.0).finished
	await get_tree().create_timer(dialogs[current_dialog][2]).timeout
	current_dialog+=1
	if current_dialog >= dialogs.size():
		$CanvasLayer/Control/RichTextLabel.visible = false
	else:
		can_interract = true
		
		
		
	pass
func _physics_process(delta):
	if can_interract and Input.is_action_just_pressed("swim"):
		print("Clicked interract")
		can_interract = false
		run_next_dialog()

func _on_animation_player_animation_finished(anim_name):
	print("finished animation")
	match anim_name:
		"start_dialog":
			await get_tree().create_timer(7).timeout
			can_interract = true
			print("Can interract and is interacting")
			
			
			
