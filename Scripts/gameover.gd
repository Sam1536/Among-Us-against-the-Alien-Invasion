extends CanvasLayer


func _ready():
	$morte.play()
	pass

func _on_button_retry_pressed():
	$select_fx.play()
	yield(get_tree().create_timer(.29), "timeout")
	if get_tree().change_scene("res://Scenes/start_screen.tscn") != OK:
			print("ALGO ÉSTA ERRADO NA SCENA ")
	if Global.is_dead:
		Global.player_health = 3
		#$player.position.x = Global.checkpoint_pos + 235



	



