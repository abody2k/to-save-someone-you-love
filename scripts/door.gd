extends Node3D



@export var opening_gate : Area3D

@export var closing_gate : Area3D


func _ready():
	opening_gate.gate_opened.connect(func (): create_tween().tween_property($door,"rotation_degrees",Vector3(0,90,0),1))
	closing_gate.gate_opened.connect(func (): create_tween().tween_property($door,"rotation_degrees",Vector3(0,0,0),1))
