extends Node3D

var dialogs = [
	["Her : love what are you doing?",null,1.0],
	["You : But you were in the subm.. who are you?",null,1.0],
	["Her : I'm your wife, don't you remember?",null,1.0],
	["You : You are not real",null,1.0],
	["Her : It seems like they lied to you, this is the real world",null,1.0],
	["*** She can't be real, this is the music and I don't have enough oxygen ***",func(): $Music.play(),1.0],
	["Her : What do you plan to do?",null,1.0],
	["You : To destroy the crystal and save the real world",null,1.0],
	["Her : Ohhh, but this is our only source of light, if you do that everything real would collapse",null,1.0],
	["Her : Do you remember what happened before that?",null,1.0],
	["You : Before what?",null,1.0],
	["Her : Before you talked to these things that told you this is not the real world",null,1.0],
	["You : Nnnno...",null,1.0],
	["Her : That means this is the real world...",null,1.0],
	["You : But I don't remember anything from this world neither",func(): Input.mouse_mode = Input.MOUSE_MODE_VISIBLE,1.0],
	["*** Make a choice ***",func(): $CanvasLayer/Control/choice.visible = true,1.0],
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
			
			
			


func _on_push_wagon_button_down():
	$CanvasLayer/Control/choice.queue_free()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	dialogs.push_back(["You shattered my heart to pieces, loved one. Farewell",func():get_tree().get_first_node_in_group("player").call("can_play"),1.0])
	can_interract = true
	run_next_dialog()


func _on_area_3d_body_entered(body):
	if body.is_in_group("wagon"):
		Singleton.pushed_crystals = true
		get_tree().change_scene_to_file("res://scenes/inside_submarine.tscn")
	elif body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scenes/egg_universe.tscn")


func _on_follow_your_parnter_button_down():
	$CanvasLayer/Control/choice.queue_free()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	dialogs = alternative_dialogs
	dialogs.push_back(["You shattered my heart to pieces, loved one. Farewell",func():get_tree().get_first_node_in_group("player").call("can_play"),1.0])
	run_dialogs_automatically()
	

var alternative_dialogs = [
	
	
	["Her : This is us, our memories, we made this me and you",func(): $SubViewport/AnimationPlayer.play("memories"),4.0],
	["You : Why I still don't remember anything",null,4.0],
	["Her : Just wait for it",null,4.0],
	["You : Can we go to the bottom? the place where I'm supposed to push the crystals? What is down there?",null,4.0],
	["Her : The only truth in this world, the end",null,4.0],
	["You : Ahh, I feel like I'm soffucating, help me I need air",null,4.0],
	["Her : Just relax, it won't take long",null,4.0],
	["...",func (): $Music.play(),10.0],
]



func run_dialogs_automatically():
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
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	else:
		run_dialogs_automatically()
