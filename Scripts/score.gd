extends Label


func _process(_delta):
	text = "0" + String(Global.fruits)
	if Global.fruits >= 10:
		text = "" + String(Global.fruits)
#	if Global.fruits >= 100:
#		text = "" + String(Global.fruits)
#	if Global.fruits >= 1000:
#		text = "" + String(Global.fruits)
