extends Area

onready var ray1 = get_node("RayCast1")
onready var ray2 = get_node("RayCast2")
onready var animation_player = get_node("AnimationPlayer")
onready var armature = get_node("Armature")
onready var particles = get_node("Particles")

const DEFAULT = 0
const CHASING = 1
const DEAD = 2

var state
var side
var player = null

func _ready():
	add_to_group(game.ZOMBIE)
	state = DEFAULT
	armature.show()
	particles.hide()
	#set_rotation(Vector3(0, randf()*2*PI, 0))
	$Timer.wait_time = rand_range(2, 10)
	$Timer.start()

func _physics_process(delta):
	if state != DEAD:
		if(state == DEFAULT):
			default_state(delta)
			if(player != null):
				if(is_near(player.translation, translation)):
					state = CHASING
		if(state == CHASING):
			chasing_state(delta)
			if(player != null):
				if(!is_near(player.translation, translation)):
					state = DEFAULT


func chasing_state(delta):
	var target_pos = player.global_transform.origin
	look_at(target_pos, Vector3.UP)
	rotation.y += PI / 2
	var angle = get_rotation().y
	set_translation(get_translation() + delta * 5 * Vector3(cos(angle), 0, -sin(angle)))

func default_state(delta):
	animation_player.play("default")
	var angle = get_rotation().y
	set_translation(get_translation() + delta * 0.5 * Vector3(cos(angle), 0, -sin(angle)))

func change_rotation():
	side = rand_range(0, 360)
	rotation_degrees = Vector3(0, side, 0)
	
func is_near(player, zombie):
	if(player.distance_to(zombie) < 10):
		return true
	else:
		return false

func set_player(p):
	player = p
	
#func _fixed_process(delta):
#	var angle = get_rotation().y
#	if ray1.is_colliding():
#		angle += delta
#		set_rotation(Vector3(0, angle, 0))
#	elif ray2.is_colliding():
#		angle -= delta
#		set_rotation(Vector3(0, angle, 0))
#	set_translation(get_translation() + delta * 0.5 * Vector3(cos(angle), 0, -sin(angle)))

func _on_enter_screen():
	if state != DEAD:
		animation_player.play("default")
		set_physics_process(false)
		ray1.set_enabled(true)
		ray2.set_enabled(true)

func _on_exit_screen():
	animation_player.stop()
	set_physics_process(false)
	ray1.set_enabled(false)
	ray2.set_enabled(false)

func _on_zombie_body_enter(body):
	if body.is_in_group(game.PLAYER):
		pass
#		set_physics_process(false)
#		armature.hide()
#		particles.set_emitting(true)


func _on_Timer_timeout():
	if(state == DEFAULT):
		change_rotation()

