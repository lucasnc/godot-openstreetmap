extends Area

var collectable =  5

func _ready():
	add_to_group(game.COLLECTABLE)

func _on_Collectable_body_entered(body):
	if body.is_in_group(game.PLAYER):
		print(body.get_groups())
		game.collectables += collectable
		queue_free()
	pass
