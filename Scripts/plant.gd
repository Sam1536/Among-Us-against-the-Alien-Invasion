extends KinematicBody2D

var facing_left = true 
var hit = false
var health = 3



onready var bullet_seed_instance = preload("res://Scenes/seed.tscn")
onready var player = Global.get("player")



func _physics_process(_delta):
	_set_plant_animation()
	
	if player:
		var distance = player.global_position.x - self.position.x
		facing_left = true if distance < 0 else false
	
	if facing_left:
		self.scale.x = 1
	else:
		self.scale.x = -1
	
	
func _set_plant_animation():
   
	var anim = "idle_P"

	if $playerdetector.overlaps_body(player):
		anim = "attack_P"
	else:
		 anim = "idle_P"	
		
	if hit == true:
		anim = "hit_p"
		
	if $anim.assigned_animation != anim:
			$anim.play(anim)

func shoot():
	var bullet = bullet_seed_instance.instance()
	get_parent().add_child(bullet)
	bullet.global_position = $spawnshoot.global_position
	
	if facing_left:
		bullet.direction = 1
	else:
		bullet.direction = -1	

func _on_playerdetector_body_entered(_body):
	$anim.play("attack_P")
	

func _on_playerdetector_body_exited(_body):
	$anim.play("idle_P")
	


func _on_hitbox_body_entered(body):
	hit = true
	$Plat_hit_fx.play()
	health -= 1
	body.velocity.y = body.jump_force /2
	yield(get_tree().create_timer(0.2),"timeout")
	hit = false
	if health < 1:
		queue_free()
		get_node("hitbox/shape").set_deferred("disabled",true)
	
	


