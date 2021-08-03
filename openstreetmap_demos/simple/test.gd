extends Spatial

onready var camera = get_node("Camera")
onready var map = get_node("Map")
var objectFlag = 0
var quads = []
var texture_cache = {}
var reference_position = Vector2(0, 0)
var x = null
var y = null
var event_timestamp = 0

func _ready():
	teleport(-25.09411, -50.15175)
	spawn_collectables()
	
func spawn_collectables():
	var count = 5
	var collectable_resource = load("res://openstreetmap_demos/third_person/objects/collectable.tscn")
	for i in count:
		var collectable = collectable_resource.instance()
		collectable.translation = Vector3(rand_range(0, 20), 0, rand_range(0, 10))
		print("gerando item ", collectable.translation)
		add_child(collectable)
		
	
	

func _on_Ground_input_event(c, event, click_pos, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
			 event_timestamp = OS.get_ticks_msec()
			elif OS.get_ticks_msec()-event_timestamp < 200:
				if event.doubleclick:
					pass
				elif camera != null:
					camera.set_target_pos(click_pos)
					map.set_center(Vector2(click_pos.x, click_pos.z))

func teleport(lat : float, lon : float):
	if map != null:
		var default_pos = osm.pos2tile(lon, lat)
		var x = default_pos.x
		var y = default_pos.y
		map.reference_position = Vector2(x, y)
		map.set_center(Vector2(0, 0))
