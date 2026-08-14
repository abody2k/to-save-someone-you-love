extends Node3D


func _unhandled_input(event):
	$SubViewport.push_input(event)
