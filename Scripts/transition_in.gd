extends CanvasLayer


func _ready():
	pass

func change_scene(path,delay = 2.5):
	$transition_effects.interpolate_property($overlay, "progress", 0.0, 1.0, 2.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT, delay)
	$transition_effects.start()
	yield($transition_effects,"tween_completed")
	assert(get_tree().change_scene(path) == OK)
	
