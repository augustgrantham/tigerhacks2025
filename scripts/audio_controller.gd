extends Node2D

func _ready():
	print("Current node path:", get_path())
	print("Has MenuMusic?", has_node("Music"))
	print("MenuMusic ref:", $Music)
	play_music()

func play_music():
	print("yes")
	$Music.play()
func play_walk():
	$Walking.play()
func play_alien_walk():
	$AlienWalking.play()
	
func pickup():
	$pickup.play()
func leave():
	$leave.play()
func play_ambience():
	$Ambient.play()
