extends Label

func _ready():
	pass
	
func _process(delta):
	text = String(game.collectables)
