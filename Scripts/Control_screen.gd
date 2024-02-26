extends Control


func _ready():
	$ReturnBTN.grab_focus()


func _on_ReturnBTN_pressed():
	$ReturnBTN/return_fx.play()
	yield(get_tree().create_timer(.29), "timeout")
	queue_free()
	Global.controloff = false
