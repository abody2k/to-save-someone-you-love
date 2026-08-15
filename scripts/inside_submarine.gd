extends Node3D


var dialogs = [
	["Old man : Are you sure you want to do it?",null,1.0],
	["You : to do what?",null,1.0],
	["Old man : To save the world you dummy!",null,1.0],
	["Her : Love, you have to find and destroy it",null,1.0],
	["You : What's going on?",null,1.0],
	["Old man : It seems like the medication is in full effect",null,1.0],
	["Her : My love, you need to find the crystal at the bottom and destroy it but you have to be aware!",null,1.0],
	["You : Be aware of what? Ahh I feel like I'm going to sleep",null,1.0],	
	["Old man : Be aware of their lies, and remember, if you hear this music it means you are not in the real world",null,1.0],

	["...",func (): get_tree().change_scene_to_file("res://scenes/ocean.tscn"),1.0],	

	]
	
	
var dialogs_after_crystals = [
	["Her : Welcome back my love",null,1.0],
	["You : I did it, I saw someone identical to you down there, I thought it was you for a second",null,1.0],
	["Her : Come on my dear, let's go to the surface. Your mission is over!",null,1.0],

	]
func _unhandled_input(event):
	$SubViewport.push_input(event)


var can_interract = false
var current_dialog = 0



func _ready():
	if Singleton.pushed_crystals:
		dialogs = dialogs_after_crystals
	
	run_dialogs_automatically()






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
