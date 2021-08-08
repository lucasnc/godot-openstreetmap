extends Area

onready var ray1 = get_node("RayCast1")
onready var ray2 = get_node("RayCast2")
onready var animation_player = get_node("AnimationPlayer")
onready var armature = get_node("Armature")
onready var particles = get_node("Particles")

var side
var dead

func _ready():
	add_to_group(game.ZOMBIE)
	dead = false
	armature.show()
	particles.hide()
	set_rotation(Vector3(0, randf()*2*PI, 0))
	$Timer.wait_time = rand_range(2, 10)
	$Timer.start()

func _physics_process(delta):
	if !dead:
		animation_player.play("default")
		var angle = get_rotation().y
		set_translation(get_translation() + delta * 0.5 * Vector3(cos(angle), 0, -sin(angle)))
			
func change_rotation():
	side = rand_range(0, 360)
	rotation_degrees = Vector3(0, side, 0)
	
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
	if !dead:
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
		dead = true
		set_physics_process(false)
		armature.hide()
		particles.show()
		particles.set_emitting(true)


func _on_Timer_timeout():
	change_rotation()
	pass # Replace with function body.
