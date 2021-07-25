extends RigidBody

func _ready():
	set_location(-25.10438, -50.15760)

func set_location(lat : float, lon : float):
	var building_pos = osm.pos2tile(lon, lat)
	#var reference_position = get_node("../Map").reference_position
	var reference_position = building_pos
	print("pos > ", reference_position + Vector2(0, 0)/osm.TILE_SIZE)
	#-612.193604, 1253.15625
	translation = Vector3(0, 0, 0)
