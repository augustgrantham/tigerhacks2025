extends CharacterBody2D


var speed = 50
var player_chase = false
var player = null
func _physics_process(delta):
	# 

	if player_chase and is_instance_valid(player):
		# 1. Calculate the direction vector from the alien to the player
		# global_position.direction_to() gives a normalized vector (length 1)
		var direction = global_position.direction_to(player.global_position)
		
		# 2. Set the CharacterBody2D's velocity
		# Velocity = Direction * Speed (e.g., Vector2(1, 0) * 250)
		velocity = direction * speed
		
		# 3. Apply the movement and handle collisions
		# move_and_slide() automatically uses 'delta' and handles physics
		move_and_slide()
	else:
		# Stop movement when not chasing
		velocity = Vector2.ZERO
		move_and_slide()

# --- Area Detection Functions ---
func _on_detection_area_body_entered(body):
	print("Detected body: ", body.name) # Check the Output panel for this line
	# Good practice: Add a check to ensure you're only chasing the player
	if body.name == "player": # or check its group, e.g., 'if body.is_in_group("player"):'
		player = body
		player_chase = true
		
func _on_detection_area_body_exited(body):
	if body == player:
		player = null
		player_chase = false
