extends Node3D


var dialogs = [
	["Welcome home, friend",null,1.0],
	["You : Where are we? who are you?",null,1.0],
	["Slow down, relax",null,1.0],
	["You : I need to go",null,1.0],
	["Go where?",null,1.0],
	["You : To save my love, to save the world",null,1.0],
	["You really believe that was real?",null,1.0],
	["You : What do you mean?",null,1.0],	
	["It was just a dream, all these worlds you had",null,1.0],
	["You : You mean it was not real?",null,1.0],	
	["It depends on what you mean by real",null,1.0],
	["You : So what is real and what is not",null,1.0],
	["That's up to you to decide, but let me tell you something, it was all you",null,1.0],
	["You were the world, the submarine operator, the hero, the crystal, the couple and even the creatures down deep",null,1.0],	
	["You : But why?",null,1.0],
	["So that you can be like me, you have to know what it feels to be everyone and everything",null,1.0],		
	["You : Who are you?",null,1.0],
	["What you will be, I can't tell you about that now, but one day you will know",null,1.0],		
	["But take your time, and do things on your own time and at your pace",null,1.0],
	["So that you can be like me, you have to know what it feels to be everyone and everything",null,1.0],		
	["You : So now I have to go and live another adventure?",null,1.0],	
	["Yeah you get the idea.",null,1.0],
	["You : Farewell then.",null,1.0],	
	["",func(): get_tree().get_first_node_in_group("player").visible = false,3.0],
	["You : welp, I'm back",func(): get_tree().get_first_node_in_group("player").visible = true,3.0],
	["a Bob haircut got you here I presume?",null,3.0],
	["You : Yup",null,3.0],
	]
	
	
func _unhandled_input(event):
	$SubViewport.push_input(event)


var can_interract = false
var current_dialog = 0

		




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
