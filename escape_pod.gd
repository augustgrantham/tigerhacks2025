extends CharacterBody2D

func _on_exit_area_body_entered(body: Node2D) -> void:
	var winCondition = global.canLeave
	if(body.name == "player"):
		if(winCondition):
			print("You win!")
