extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(8.0).timeout
	hide()
	get_tree().call_deferred("change_scene_to_file", "res://scenes/world.tscn")
