extends Area2D


func _ready():
	pass


func _on_trampolim_body_entered(body):
	print("esta funcionando")
	body.velocity.y = body.jump_force 
	$anim.play("jump")
