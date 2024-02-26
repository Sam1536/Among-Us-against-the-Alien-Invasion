extends Node

var checkpoint_pos = null


func _ready():
	Global.fruits = 0
	if Global.is_dead:
		Global.player_health = 3
	$music_game.play()
	

func _on_trigger_PlayerEntered_camera():
	$Boss_camera.current = true


func _on_Boss_BossDead():
	$Boss_camera.current = false
