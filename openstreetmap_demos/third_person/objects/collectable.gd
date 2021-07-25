extends Area

func _ready():
	add_to_group(game.COLLECTABLE)

func set_location(lat : float, lon : float):
	var building_pos = osm.pos2tile(lon, lat)
	#var reference_position = get_node("../Map").reference_position
	var reference_position = building_pos
	print("pos > ", reference_position + Vector2(0, 0)/osm.TILE_SIZE)
	#-612.193604, 1253.15625
	translation = Vector3(0, 0, 0)

func _on_Collectable_body_entered(body):
	if body.is_in_group(game.PLAYER):
		print(body.get_groups())
		queue_free()
	pass
