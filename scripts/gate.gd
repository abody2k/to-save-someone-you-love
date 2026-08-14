extends Area3D


@export var required_bubbles = 10

var current_no_of_bubbles = 0


signal gate_opened


func _on_gate_opened():
	current_no_of_bubbles+=1
	
	if current_no_of_bubbles == required_bubbles:
		gate_opened.emit()
		
		
