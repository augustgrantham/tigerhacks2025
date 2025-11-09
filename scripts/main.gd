extends Node

# Use these constants for clarity instead of string paths
const START_MENU_SCENE = preload("res://scenes/menu.tscn")
const WORLD_SCENE = preload("res://scenes/world.tscn")
const END_SCENE = preload("res://scenes/end_scene.tscn") 
const WIN_SCENE = preload("res://scenes/win_scene.tscn") 
# Store a reference to the currently active child scene
var current_scene = null

func _ready():
	# Load the starting scene (the Start Menu) first
	# If you want to start directly in the World, change this line:
	change_scene(START_MENU_SCENE) 

# --- Scene Management Function ---
func change_scene(next_scene_resource):
	# 1. Check if a scene is currently running and remove it
	if current_scene:
		current_scene.queue_free() # Safely remove the old scene
		current_scene = null

	# 2. Instantiate the new scene
	var new_scene_instance = next_scene_resource.instantiate()
	
	# 3. Add the new scene as a child of the Main node
	add_child(new_scene_instance)
	
	# 4. Update the reference
	current_scene = new_scene_instance
	
	print("Changed scene to: " + next_scene_resource.get_path())


# --- Helper functions to call from other scripts ---

# Call this from a button in your Start Menu
func start_game():
	change_scene(WORLD_SCENE)
# Call this when the player dies or meets a win condition in the World scene
func game_over():
	change_scene(END_SCENE)
func game_win():
	change_scene(WIN_SCENE)
