extends Control
func _ready():
	print("step 1")
	#audio_controller.play_music()
func _on_start_button_pressed() -> void:
	hide()
	# 2. Change the scene
	get_tree().call_deferred("change_scene_to_file", "res://scenes/intro.tscn")

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
