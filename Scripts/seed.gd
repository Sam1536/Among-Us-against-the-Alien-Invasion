extends Area2D

var velocity = Vector2.ZERO
var speed_shoot = -100
var direction = 1

func _physics_process(delta):
	velocity.x = speed_shoot * direction * delta
	translate(velocity)


func _on_cleannode_screen_exited():
	queue_free()
