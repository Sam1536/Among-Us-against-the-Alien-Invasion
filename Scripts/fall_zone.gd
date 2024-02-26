extends Area2D


func _ready():

	pass


func _on_fall_zone_body_entered(body):
	
	if body.name == "Player":
		Global.player_life -= 1
		Global.player_health = 3
	if body.name == "Player" and Global.player_life < 1:
		if get_tree().change_scene("res://prefeb/gameover.tscn") != OK:
			print("ALGO ÉSTA ERRADO NA SCENA ")
	else:
		get_tree().reload_current_scene()
	
