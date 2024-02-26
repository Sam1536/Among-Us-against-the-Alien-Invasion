extends Area2D

onready var change = get_parent().get_node("transition_in") 
export var path: String

func _ready():
	
	pass


func _on_End_body_entered(body):
	if body.name == "Player":
		$anim.play("end")
		yield($anim, "animation_finished")
		$anim.play("end_anim")
		$shape.queue_free()
		$particles.emitting = true
		$particles2.emitting = true
		change.change_scene(path)
		Global.checkpoint_pos = null
		$wins_fx.play()
		
		print("ganhou o jogo")


func _on_anim_animation_finished(_anim_name):
	pass # Replace with function body.
