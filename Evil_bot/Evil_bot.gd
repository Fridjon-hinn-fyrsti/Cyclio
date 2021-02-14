extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector3(0,0,0)
# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()
onready var material = get_node("MechaTrooper").get_surface_material(0)
onready var color = material.albedo_color
var alive = true

func _ready():
	rng.randomize()

var damage = 0
func fix_angle():
	var planet_vector = (transform.origin - planet.transform.origin).normalized()
	transform.basis.y = planet_vector
	transform.basis.z = transform.basis.y.rotated(transform.basis.x, deg2rad(90))
	transform.basis.x = transform.basis.y.cross(transform.basis.z)
	transform = transform.orthonormalized()
	
func is_dead():
	return not alive

func hit(direction):
	damage += 1
	material.albedo_color = Color(color.r, color.g - 0.5*damage, color.b - 0.5*damage)
	if damage == 2:
		 #mat1.albedo_color = Color("5f2121")
		#get_node("MechaTrooper") = Material()
		#get_node("MechaTrooper").queue_free()
		#add_child(M)
		alive = false
		transform.basis = transform.basis.rotated(transform.basis.x, deg2rad(90))
	
	#move_and_slide(-direction*5000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
onready var planet = get_parent().get_node("Planet")
var move_force = 20
func _process(delta):
	if alive:
		if rng.randf_range(-10.0, 10.0) < -5:
			velocity -= move_force* global_transform.basis.z
			
		if rng.randf_range(-10.0, 10.0) < -5:
			velocity += move_force* global_transform.basis.z

		if rng.randf_range(-10.0, 10.0) < -5:
			velocity -= move_force* global_transform.basis.x

		if rng.randf_range(-10.0, 10.0) < -5:
			velocity += move_force* global_transform.basis.x
		move_and_slide(velocity)
		fix_angle()
	velocity = Vector3(0,0,0)
	#add_central_force(velocity)
	#velocity = Vector3(0,0,0)
