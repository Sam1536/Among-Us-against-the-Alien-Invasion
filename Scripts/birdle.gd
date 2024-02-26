extends EnemyBase 



func _process(_delta):
	_set_animation()
	velocity.y = 0
	if $ray_wall.is_colliding():
		$ray_wall.scale.x *= -1
		novo_move_direction *= -1
		$anim.play("run") 
	
		
		
