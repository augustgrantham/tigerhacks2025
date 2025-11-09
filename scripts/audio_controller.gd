extends Node
@export var mute: bool = false
func _ready():
	if not mute:
		play_music()

func play_music():
	if not mute:
		$MenuMusic.play() 

func play_walk():
	if not mute:
		$PlayerFootsteps.play()
		
