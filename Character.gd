extends KinematicBody

const gC = 9.8

var gravity = Vector3.DOWN
var speed = 4
var velocity = Vector3()
var x_angle
var z_angle
onready var planet = get_parent().get_node("Planet")

onready var camera = get_node("Camera")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(_delta):
	get_input()
	#interpolate_velocity()
	#camera_follow()
	velocity += get_relative_gravity()
	velocity = move_and_slide(velocity)
	
func sign_of(n):
	if n > 0:
		return 1.0
	return -1.0
	
func camera_follow():
	var pos = global_transform.origin
	var c_pos = camera.global_transform.origin
	#rotation.x = 2*(pos.z*cos(rotation.y) + pos.x*sin(rotation.y))/pos.distance_to(c_pos)
	#rotation.z = 2*(pos.z*sin(rotation.y) - pos.x*cos(rotation.y))/pos.distance_to(c_pos)
	
func y_velocity():
	
	pass
	
#	var pos = global_transform.origin
#	var y_angle = rotation.y
#	x_angle = rotation.x
#	#x_angle = get_relative_gravity().angle_to(Vector3.RIGHT)
#	#z_angle = get_relative_gravity().angle_to(Vector3.BACK)
#
#	var raw_vel = velocity
#	velocity.x = cos(y_angle)*raw_vel.x*sign_of(pos.y) + sin(y_angle)*raw_vel.z*sign_of(pos.y)
#	velocity.z = cos(y_angle)*raw_vel.z*sign_of(pos.y) + sin(y_angle)*raw_vel.x*sign_of(pos.y)
#	#velocity.y = cos(x_angle)*raw_vel.x + cos(z_angle)*raw_vel.z
#
#	#velocity.y = cos(x_angle)*raw_vel.x + cos(z_angle)*raw_vel.z


#	var raw_x = velocity.x
#	var raw_z = velocity.z
#	velocity.x = cos(rotation.y)*raw_x + sin(rotation.y)*raw_z
#	velocity.z = - cos(rotation.y)*raw_z + sin(rotation.y)*raw_x
	
	
		
func get_relative_gravity():
	gravity = global_transform.origin.direction_to(planet.global_transform.origin)
	return gC * gravity

func get_input():
	velocity = Vector3.ZERO
	
	x_angle = get_relative_gravity().angle_to(Vector3.RIGHT)
	z_angle = get_relative_gravity().angle_to(Vector3.BACK)
	
	if Input.is_action_pressed("m_up"):
		velocity.z -= cos(rotation.y)*speed
		velocity.x -= sin(rotation.y)*speed
		velocity.y += (sin(x_angle)*speed + sin(z_angle)*speed)*sin(rotation.x)*cos(rotation.y)
	if Input.is_action_pressed("m_down"):
		velocity.z += cos(rotation.y)*speed
		velocity.x += sin(rotation.y)*speed
		velocity.y -= (sin(x_angle)*speed + sin(z_angle)*speed)*cos(rotation.x)*cos(rotation.y)
	if Input.is_action_pressed("m_left"):
		velocity.x -= cos(rotation.y)*speed
		velocity.z += sin(rotation.y)*speed
		velocity.y += (sin(x_angle)*speed + sin(z_angle)*speed)*cos(rotation.x)*sin(rotation.y)
	if Input.is_action_pressed("m_right"):
		velocity.x += cos(rotation.y)*speed
		velocity.z -= sin(rotation.y)*speed
		velocity.y -= (sin(x_angle)*speed + sin(z_angle)*speed)*sin(rotation.x)*sin(rotation.y)
	if Input.is_action_pressed("fire"):
		print_debug(x_angle)
		print_debug(z_angle)
	if Input.is_action_pressed("close"):
		get_tree().quit()
		
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# Replace with function body.
	
func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		#if rotation.x > 0 and rotation.x < 2:
		rotation.y -= deg2rad(movement.x * 0.2)
		
		rotation.x -= deg2rad(movement.y * 0.2)*cos(rotation.z)
		#rotation.z -= deg2rad(movement.y * 0.2)*sin(rotation.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
