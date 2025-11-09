extends Control

const world = preload("res://scenes/world.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(7.0).timeout
	
	get_tree().call_deferred("change_scene_to_file", "res://scenes/world.tscn")
