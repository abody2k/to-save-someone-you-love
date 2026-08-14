extends Node3D


const PROBE = preload("res://scenes/probe.tscn")

func _on_timer_timeout():
	var probe = PROBE.instantiate()
	
	add_child(probe)
	
	probe.global_position = $aim.global_position

	probe.global_basis = global_basis.looking_at($aim.global_basis.z) 
