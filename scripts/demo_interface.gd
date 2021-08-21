extends CanvasLayer

func _ready():
	pass

func _physics_process(delta):
	$Control/FPS.text = "%d FPS" % Performance.get_monitor(Performance.TIME_FPS)

func _on_BackToMenu_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")
