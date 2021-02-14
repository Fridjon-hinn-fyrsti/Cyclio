extends KinematicBody

const gC = 9.8
const move_force = 30
const jump_force = 200

var gravity = Vector3.DOWN
var velocity = Vector3()

onready var planet = get_parent().get_node("Planet")
onready var camera1 = get_node("Camera")
onready var gun1 = get_node("AK 47")
	
func _physics_process(_delta):
	resolve_input()

	velocity += get_relative_gravity()
	move_and_slide(velocity)

	var planet_vector = (transform.origin - get_parent().get_node("Planet").transform.origin).normalized()
	var angle = planet_vector.angle_to(transform.basis.y)
	transform.basis.y = planet_vector
	if abs(velocity.project(transform.basis.x).dot(transform.basis.x)) > 0.1:
		if velocity.project(transform.basis.x).dot(transform.basis.x) > 0:
			angle *= -1
		transform.basis.x = transform.basis.x.rotated(transform.basis.z, angle)
	transform = transform.orthonormalized()
	velocity = Vector3.ZERO

func get_relative_gravity():
	gravity = global_transform.origin.direction_to(planet.global_transform.origin)
	return gC * gravity
	
func resolve_input():
	velocity = Vector3.ZERO
	
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

	if Input.is_action_just_pressed("aim"):
		gun1.get_node("FPS_camera").make_current()
	if Input.is_action_just_released("aim"):
		gun1.reset_rotation()
		camera1.make_current()
	if Input.is_action_just_pressed("focus"):
		gun1.focus(true)
	if Input.is_action_just_released("focus"):
		gun1.focus(false)
	if Input.is_action_pressed("fire"):
		gun1.shoot()
	if Input.is_action_just_pressed("reload"):
		gun1.reload()
	if Input.is_action_pressed("close"):
		get_tree().quit()
		
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		var sensitivity = 0.2
		if not camera1.current:
			sensitivity = 0.1
		transform.basis = transform.basis.rotated(transform.basis.y, deg2rad(-movement.x * sensitivity))
		#transform.basis = transform.basis.rotated(transform.basis.x, deg2rad(-movement.y * 0.2))
		#rotation.x -= deg2rad(movement.y * 0.2)*cos(rotation.z)
		#rotation.z -= deg2rad(movement.y * 0.2)*sin(rotation.y)
