extends KinematicBody2D
class_name EnemyBase

export var speed = 90
export var health = 1
export var velocity = Vector2.ZERO
var novo_move_direction = -1
var gravity = 1200
var hits = false


func _physics_process(_delta):
	
	velocity.x = speed * novo_move_direction  
	
	if novo_move_direction == 1:
		$sprite.flip_h = true
	else:
		$sprite.flip_h = false
		
	velocity = move_and_slide(velocity)

	
func apply_gravity(delta):
	velocity.y += gravity * delta

func _on_anim_animation_finished(anim_name):
	if anim_name == "idle":
		$ray_wall.scale.x *= -1
		novo_move_direction *= -1
		$anim.play("run") 
	
func _set_animation():
   
	var anim = "run"

	if $ray_wall.is_colliding():
		anim = "idle"
	
	if velocity.x != 0:
		 anim = "run"	
	
	if hits == true:
		anim = "hit"
	
	if $anim.assigned_animation != anim:
		$anim.play(anim)



func _on_hit_box_body_entered(body):
	hits = true
	health -= 1
	body.velocity.y = body.jump_force /2
	$hit_fx.play()
	yield(get_tree().create_timer(.2),"timeout")
	hits = false
	if health < 1:
		get_node("hit_box/shape").set_deferred("disabled",true)
		set_physics_process(false)
		get_node("shape").set_deferred("disabled",true)
		yield(get_tree().create_timer(.2), "timeout")
		queue_free()
	

