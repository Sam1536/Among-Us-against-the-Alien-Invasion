extends KinematicBody2D

var UP = Vector2.UP
var velocity = Vector2.ZERO #velocity é o vector 2
var move_speed = 400
var gravity = 1200
var jump_force = -780
var is_grounded 

#varGlobal.player_health = 3
var max_health = 3
var player_life = 3

var hit = false
#var facingRight = true

var knockback_dir = 1
var knockback_int = 3000


var is_pushing = false


onready var raycasts = $raycasts


signal change_life(_player_health) # sinal personalizado 

func _ready():
	Global.set("player",self)
	connect("change_life",get_parent().get_node("HUD/HBoxContainer/control_life"),"_on_change_life")
	emit_signal("change_life",max_health)
	if Global.checkpoint_pos != null:
		global_position.x = Global.checkpoint_pos

	#position.x = Global.checkpoint_pos + 235
	

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.x = 0
	if !hit: 
		_get_input()

	if $pushright.is_colliding():
		var object = $pushright.get_collider()
		object.move_and_slide(Vector2(30,0) * move_speed * delta)
		is_pushing = true
	elif $pushlefth.is_colliding():
		var object1 = $pushlefth.get_collider()
		object1.move_and_slide(Vector2(-30,0) * move_speed * delta)
		is_pushing = true	
	else:		
		is_pushing = false
	
	#move_and_slide(velocity)
	velocity = move_and_slide(velocity,UP)
	#print(velocity.y)
	is_grounded = _check_is_ground()
	
	if is_grounded:
		$Shadow.visible = true 
	else:
		$Shadow.visible = false
	_set_play_animation()
	
	for platforms in get_slide_count():
		var collision = get_slide_collision(platforms)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision,self)
				
func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.x = lerp(velocity.x,move_speed * move_direction, 0.2) 
	
	if move_direction != 0:
		$sprite.scale.x = move_direction 
#		$right.scale.x = move_direction 
#		$left.scale.x = move_direction 
		$effects.scale.x = move_direction 
		
	if velocity.x > 1:
		$pushright.set_enabled(true)
	else:
		$pushright.set_enabled(false)			
	
	if velocity.x < -1:
		$pushlefth.set_enabled(true)
	else:
		$pushlefth.set_enabled(false)			
	
func _input(event):
	if event.is_action_pressed("jump") && is_grounded:
		velocity.y = jump_force /2
		$jump_fx.play()
	
	
func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
		return false

	
func _set_play_animation():
   
	var anim = "idle_play"

	if !is_grounded:
		 anim = "jump_play"
	elif velocity.x != 0 or is_pushing:
		 anim = "run_play"
		 $effects.set_emitting(true)
	if velocity.y > 0 and !is_grounded:
		anim = "fall_play"
	if hit:
		anim = "hit_play"
	if $anim.assigned_animation != anim:
		$anim.play(anim)

func knockback():
	if $right.is_colliding():
		velocity.x = -knockback_dir * knockback_int
	if$left.is_colliding():
		velocity.x = knockback_dir * knockback_int
	
	velocity = move_and_slide(velocity)


func _on_hurt_box_body_entered(_body):
	player_damage()
	
func hit_checkpoint():
	Global.checkpoint_pos = global_position.x
	

func _on_head_shape_body_entered(body):
	if body.has_method("destroy"):
		body.destroy()


func _on_hurt_box_area_entered(_area):
	player_damage()
	
func gameover():
	if Global.player_health < 1:
		queue_free()
		Global.is_dead = true
		Global.player_life -= 1 
		Global.player_health = 3
		get_tree().reload_current_scene()
	if Global.player_life < 1:
		if get_tree().change_scene("res://prefeb/gameover.tscn") != OK:
			print("ALGO ÉSTA ERRADO NA SCENA ")
	print('vc morreu')


func player_damage():	
	Global.player_health -= 1
	hit = true
	$hitP_fx.play()
	emit_signal("change_life",Global.player_health)
	knockback()
	get_node("hurt_box/shape").set_deferred("disabled", true)
	yield(get_tree().create_timer(.5),"timeout")
	get_node("hurt_box/shape").set_deferred("disabled", false)
	hit = false
	gameover()



func _on_trigger_PlayerEntered():
	$camera.current = false
	


func _on_Boss_BossDead():
	$camera.current = true
