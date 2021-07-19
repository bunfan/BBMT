extends Sprite


func loop(beat):
	if beat % 2 == 0:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("loop")

func update_animation(path):
	print("Swapping Image")
	texture = load(path)
