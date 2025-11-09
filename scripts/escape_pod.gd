extends CharacterBody2D

func _on_exit_area_body_entered(body: Node2D) -> void:
	var winCondition = global.canLeave
	if(body.name == "player"):
		if(winCondition):
			hide()
			AudioController.leave()
			# 2. Change the scene
			get_tree().call_deferred("change_scene_to_file", "res://scenes/win_scene.tscn")
