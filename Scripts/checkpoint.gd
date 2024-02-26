extends Area2D


func _ready():
	
	pass


func _on_checkpoint_body_entered(body):
	if body.name == "Player":
		$check_fx.play()
		body.hit_checkpoint()
		$anim.play("justpassed")
		yield($anim, "animation_finished")
		$anim.play("checkpoint")
		$shape.queue_free()
		#Global.checkpoint_pos = null
		$check_fx.stop()
		

func _on_anim_animation_finished(_anim_name):
	pass # Replace with function body.
