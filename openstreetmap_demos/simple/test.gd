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
var collectables_resource = ["res://scenes/collectable3.tscn", "res://scenes/collectable2.tscn", "res://scenes/collectable.tscn"]

func _ready():
	game.player_dead = false
	teleport(-25.09487, -50.15469)
	var collectables_count = collectables_resource.size()
	for i in collectables_count:
		print(i)
		spawn_collectables((i + 1) * 2, collectables_resource[i])

func spawn_zombie(count, position):
	for i in count:
		var zombie_resource = load("res://scenes/zombie.tscn")
		var zombie = zombie_resource.instance()
		zombie.translation = Vector3(rand_range(position.x, 5), 0, rand_range(position.z, 5))
		zombie.set_player($Player)
		print("gerando zumbi ", zombie.translation)
		add_child(zombie)

func spawn_collectables(collectable_count, resource):
	var collectable_resource = load(resource)
	for i in collectable_count:
		var collectable = collectable_resource.instance()
		collectable.translation = Vector3(rand_range(0, 200), 0, rand_range(0, 200))
		print("gerando item ", collectable.translation)
		spawn_zombie(collectable_count * 5, collectable.translation)
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
