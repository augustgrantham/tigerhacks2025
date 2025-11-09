extends CharacterBody2D
var wander_direction = Vector2.ZERO
var wander_timer = 0.0
var health = 3;
var speed = 50
var player_chase = false
var player = null
var damaged = false
var delay = false

func walk():
	if(!delay):
		AudioController.play_alien_walk()
		delay = true
		await get_tree().create_timer(0.45).timeout
		delay = false
func _physics_process(delta):
	if player_chase and is_instance_valid(player):
		wander_timer = 0
		var direction = global_position.direction_to(player.global_position)
		speed = 50
		if(damaged):
				speed *= 0.66
		velocity = direction * speed 
		walk()
	else:
		if wander_timer <= 0.0:
			wander_timer = 5.0
			if randf() < 0.5:
				wander_direction = Vector2.ZERO
			else:
				walk()
				var rand_x = randf_range(-1.0, 1.0)
				var rand_y = randf_range(-1.0, 1.0)
				wander_direction = Vector2(rand_x, rand_y).normalized()
		if wander_timer <= 1.5:
			speed = 0
		else:
			speed = 17
			if(damaged):
				speed *= 0.66
		velocity = velocity.lerp(wander_direction * speed, 0.1) # smooth turn
	wander_timer -= delta
	
	move_and_slide()
# --- Area Detection Functions ---
func _on_detection_area_body_entered(body):
	# Good practice: Add a check to ensure you're only chasing the player
	if body.name == "player": # or check its group, e.g., 'if body.is_in_group("player"):'
		player = body
		player_chase = true		
func _on_detection_area_body_exited(body):
	if body == player:
		player = null
		player_chase = false





func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.name == "Area2D":
		if(!damaged):
			health -= 1
			damaged = true
			$AnimatedSprite2D.skew += .25
			if(health == 0):
				queue_free()
			await get_tree().create_timer(3.0).timeout
			damaged = false
