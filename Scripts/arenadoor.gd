extends StaticBody2D


signal DoorClosed


func _ready():
	pass

func _on_trigger_PlayerEntered():
	$anim.play("active")
	
	


func _on_Boss_BossDead():
	$anim.play("inactive")
