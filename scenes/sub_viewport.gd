extends Node3D


func _unhandled_input(event):
	$SubViewport.push_input(event)


func _on_final_body_entered(body):
	if body.is_in_group("player"):
		$SubViewport/AnimationPlayer.play("start_dialog")
		$SubViewport/final.queue_free()
