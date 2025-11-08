extends CharacterBody2D

var speed = 200

var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("front idle")

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
