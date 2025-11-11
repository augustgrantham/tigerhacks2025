extends Control




func _on_restart_button_pressed() -> void:
	hide()
	# 2. Change the scene
	get_tree().call_deferred("change_scene_to_file", "res://scenes/world.tscn")


func _on_menu_button_pressed() -> void:
	hide()
	# 2. Change the scene
	get_tree().call_deferred("change_scene_to_file", "res://scenes/menu.tscn")
