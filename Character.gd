extends KinematicBody

const gC = 9.8

var gravity = Vector3.DOWN
var speed = 4
var velocity = Vector3()
onready var planet = get_parent().get_node("Planet")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _integrate_forces(state):
	pass
	#state.transform.basis.y = (get_parent().get_node("Planet").global_transform.origin - global_transform.origin).normalized()
	
func _physics_process(_delta):
	resolve_input()
	#interpolate_velocity()
	#camera_follow()
	velocity += get_relative_gravity()
	velocity = move_and_slide(velocity)
	transform.basis.y = (transform.origin - get_parent().get_node("Planet").transform.origin).normalized()
	transform = transform.orthonormalized()
	
	
func get_relative_gravity():
	gravity = global_transform.origin.direction_to(planet.global_transform.origin)
	return gC * gravity
	
var move_force = 30
var jump_force = 200
func resolve_input():
	velocity = Vector3.ZERO
	
	#x_angle = get_relative_gravity().angle_to(Vector3.RIGHT)
	#z_angle = get_relative_gravity().angle_to(Vector3.BACK)

	if Input.is_action_pressed("movement_forward"):
		velocity -= move_force* global_transform.basis.z
		
	if Input.is_action_pressed("movement_backward"):
		velocity += move_force* global_transform.basis.z

	if Input.is_action_pressed("movement_left"):
		velocity -= move_force* global_transform.basis.x

	if Input.is_action_pressed("movement_right"):
		velocity += move_force* global_transform.basis.x
	#jump:
	if Input.is_action_just_pressed("movement_jump"):
		velocity += jump_force* global_transform.basis.y

	if Input.is_action_pressed("fire"):
		print("bang")
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
		transform.basis = transform.basis.rotated(transform.basis.y, deg2rad(-movement.x * 0.2))
		#transform.basis = transform.basis.rotated(transform.basis.x, deg2rad(-movement.y * 0.2))
		#rotation.x -= deg2rad(movement.y * 0.2)*cos(rotation.z)
		#rotation.z -= deg2rad(movement.y * 0.2)*sin(rotation.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
