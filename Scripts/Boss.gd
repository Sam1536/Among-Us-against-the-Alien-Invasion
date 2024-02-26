extends EnemyBase

signal BossDead

func _ready():
	set_physics_process(false)
	
	
	
func _physics_process(delta):
	apply_gravity(delta)
	_set_boss_animations()
	


func _set_boss_animations():
   
	var anim = "Boss_run"

	if $ray_wall.is_colliding():
		anim = "idle"
	elif velocity.x != 0 and health > 70:
		anim = "Boss_run"
	elif velocity.x != 0 and health < 70:	
		anim = "angry_run"
		speed = 400	
	if velocity.x != 0 and health < 40:	
		anim = "angry_run"
		speed = 700
	if velocity.x != 0 and health < 15:	
		anim = "angry_run"
		speed = 1000
	if velocity.x != 0 and health < 5:	
		anim = "angry_run"
		speed = 10
	print(health)
	print(speed)
		
		
	
	if hits == true:
		anim = "Boss_hit"
	if health < 1:
		anim = "Boss_die"
		emit_signal("BossDead")
	if $anim.assigned_animation != anim:
		$anim.play(anim)


func _on_trigger_PlayerEntered():
	set_physics_process(true)
	

func _on_arenadoor2_DoorClosed():
	pass # Replace with function body.
