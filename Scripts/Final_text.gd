extends Node2D


func _ready():
	 $fina_fx.play()


func _on_fina_fx_finished():
	if $fina_fx.playing == false:
		get_tree().quit()
	
