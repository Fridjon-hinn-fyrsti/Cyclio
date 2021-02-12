extends KinematicBody

var gC = 9.8
var gravity = Vector3.DOWN
var speed = 4
var velocity = Vector3()
var x_angle
var z_angle
onready var planet = get_parent().get_node("Planet")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(_delta):
	get_input()
	interpolate_velocity()
	velocity += get_relative_gravity()
	velocity = move_and_slide(velocity)
	
func interpolate_velocity():
	x_angle = get_relative_gravity().angle_to(Vector3.RIGHT)
	z_angle = get_relative_gravity().angle_to(Vector3.BACK)
	var raw_vel = velocity
	velocity.x = sin(x_angle)*raw_vel.x
	velocity.z = sin(z_angle)*raw_vel.z
	
	velocity.y = cos(x_angle)*raw_vel.x + cos(z_angle)*raw_vel.z
		
func get_relative_gravity():
	gravity = global_transform.origin.direction_to(planet.global_transform.origin)
	return gC * gravity

func get_input():
	velocity = Vector3.ZERO
	if Input.is_action_pressed("m_up"):
		velocity.z -= speed
	if Input.is_action_pressed("m_down"):
		velocity.z += speed
	if Input.is_action_pressed("m_left"):
		velocity.x -= speed
	if Input.is_action_pressed("m_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_select"):
		print_debug(x_angle)
		print_debug(z_angle)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
