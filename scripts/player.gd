extends CharacterBody2D
const TIGHT_BEAM_TEX = preload("res://assets/tightbeam.png")
const WIDE_BEAM_TEX = preload("res://assets/smallerroundcone.png")
@export var speed: float = 200.0
signal blasting
var current_dir = "none"
var flashlight_on := true
var flicker_timer := 0.0
var health = 3

@export var can_use_tight_beam := true
@export var is_tight_beam_active := false

func _ready():
	$AnimatedSprite2D.play("front idle")
	$PointLight2D.texture = WIDE_BEAM_TEX
	$PointLight2D.energy = 2.5 
	
func _process(delta: float) -> void:
	flicker_timer += delta
	if flicker_timer > 0.05:
		flicker_timer = 0.0
		if flashlight_on and can_use_tight_beam:
			$PointLight2D.energy = randf_range(1.8, 2.2)
		elif !is_tight_beam_active and !can_use_tight_beam:
			$PointLight2D.energy = randf_range(0.8, 1.3)
	if Input.is_action_just_pressed("flashlight_toggle"):
		if can_use_tight_beam:
			activate_tight_beam()
		else:
			print("Tight beam is on cooldown!")


func activate_tight_beam():
	# --- 1. SETUP & COOLDOWN START ---
	can_use_tight_beam = false
	is_tight_beam_active = true
	blasting.emit()
	$PointLight2D/Area2D/CollisionShape2D.disabled = false 
	var original_texture = $PointLight2D.texture
	var original_energy = $PointLight2D.energy
	
	# --- 2. ACTIVATE TIGHT BEAM (Duration: 2 seconds) ---
	$PointLight2D.texture = TIGHT_BEAM_TEX
	$PointLight2D.energy = 4.0
	
	# Wait for 2 seconds (Active Duration)
	await get_tree().create_timer(2.0).timeout
	
	# --- 3. REVERT LIGHT ---
	$PointLight2D.texture = original_texture
	$PointLight2D.energy = original_energy 
	is_tight_beam_active = false
	$PointLight2D/Area2D/CollisionShape2D.disabled = true
	
	# --- 4. COOLDOWN DURATION (3 seconds) ---
	# Wait for 3 seconds (Cooldown Duration)
	$PointLight2D.energy = 1
	await get_tree().create_timer(3.0).timeout
	# --- 5. COOLDOWN END ---
	$PointLight2D.energy = original_energy
	can_use_tight_beam = true
func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(2)
		direction.x -= 1
	if Input.is_action_pressed("ui_up"):
		play_anim(3)
		current_dir = "up"
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		play_anim(4)
		current_dir = "down"
		direction.y += 1
	if direction.length() > 0:
		direction = direction.normalized()
	velocity = direction * speed	
	if direction.length() == 0:
		play_anim(0)
	move_and_slide()
	var mouse_pos = get_global_mouse_position()
	var angle = (mouse_pos - global_position).angle() - deg_to_rad(95)
	$PointLight2D.rotation = lerp_angle($PointLight2D.rotation, angle, 10 * delta)
	##$PointLight2D/Area2D.rotation = (($PointLight2D.rotation) / (2)) 
	
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	match(dir):
		"right":
			anim.flip_h = false
			if movement == 1:
				anim.play("side walk")
			elif movement == 0:
				anim.play("side idle")
		"left":
			anim.flip_h = true
			if movement == 2:
				anim.play("side walk")
			elif movement == 0:
				anim.play("side idle")
		"up":
			if movement == 3:
				anim.play("back walk")
			elif movement == 0:
				anim.play("back idle")
		"down":
			if movement == 4:
				anim.play("front walk")
			elif movement == 0:
				anim.play("idle")


func _on_hit_area_body_entered(body: Node2D) -> void:
	if(body.name.begins_with("Alien")):
		print("youch")
		health -= 1
		on_take_damage()
		if(health <= 0):
			queue_free()
		await get_tree().create_timer(3.0).timeout
		
func on_take_damage():
	for i in 4:
		modulate = Color(1.0, 0.063, 0.035)
		await get_tree().create_timer(0.5).timeout
		modulate = Color(1.0, 1.0, 1.0)
		
