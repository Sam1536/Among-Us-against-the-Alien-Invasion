extends Control


func _ready():
	$controls/StartBTN.grab_focus()
	Global.player_health = 3
	Global.player_life = 3
	Global.checkpoint_pos = null
	
	

func _physics_process(_delta):
	if !Global.controloff:
		$controls/StartBTN.grab_focus()
		Global.controloff = true

func _on_StartBTN_pressed():
	$start_fx.play()
	yield(get_tree().create_timer(.29), "timeout")
	get_tree().change_scene("res://levels/Level_01.tscn")


func _on_controlsBTN_pressed():
	$control_fx.play()
	yield(get_tree().create_timer(.29), "timeout")
	var controlscreen = load("res://Scenes/Control_screen.tscn").instance()
	get_tree().current_scene.add_child(controlscreen)


func _on_QuitBTN4_pressed():
	$quit_fx.play()
	yield(get_tree().create_timer(.29), "timeout")
	get_tree().quit()
