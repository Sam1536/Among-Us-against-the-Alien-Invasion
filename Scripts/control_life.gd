extends Control

var life_size = 32


func _on_change_life(player_health):
	$icon_life.rect_size.x = Global.player_health * life_size
