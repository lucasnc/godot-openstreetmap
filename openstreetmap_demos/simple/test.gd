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
	teleport(-25.094072, -50.152797)
	
	print("gerando caixa...")
	var mesh = MeshInstance.new()
	mesh.set_mesh(CubeMesh.new())
	var player_position = $Player.transform.origin
	mesh.transform.origin = player_position
	print("posição do player", player_position)
	print("posição da caixa", mesh.transform.origin)
	add_child(mesh)

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
