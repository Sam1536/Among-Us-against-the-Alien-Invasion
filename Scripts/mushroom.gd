extends EnemyBase 


func _physics_process(_delta):
	_set_animation()
	apply_gravity(_delta)
	
