extends Area2D


func _ready():
	pass


func _on_fire_body_entered(body):
	if body.has_method("player_damage"):
		body.player_damage()



func _on_Timer_start_timeout():
	$anim.play("fire_on")
	$shape_fire.set_deferred("disabled", false)


func _on_Timer_stop_timeout():
	$anim.play("fire_off")
	$shape_fire.set_deferred("disabled", true)
