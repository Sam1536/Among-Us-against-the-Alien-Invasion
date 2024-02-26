extends Area2D


export var fruits = 1


func _on_apple_body_entered(_body):
	$anim.play("collected")
	$effects_sounds.play()
	Global.fruits += fruits
	print(name)

func _on_anim_animation_finished(anim_name):
	if anim_name == "collected":
		queue_free()
		
	
