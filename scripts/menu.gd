extends CenterContainer

func _on_Button_pressed(path):
	get_tree().change_scene(path)
	
func _input(event):
	if Input.is_action_pressed("ui_select"):
		get_tree().change_scene("res://scenes/main.tscn")
	elif Input.is_action_pressed("ui_page_up"):
		get_tree().change_scene("res://openstreetmap_demos/simple/test.tscn")
