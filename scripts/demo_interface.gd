extends CanvasLayer

func _ready():
	pass

func _physics_process(delta):
	if(game.player_dead):
		$Control/GameOver.visible = true
	else:
		$Control/GameOver.visible = false
	$Control/FPS.text = "%d FPS" % Performance.get_monitor(Performance.TIME_FPS)
	
func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/menu.tscn")
