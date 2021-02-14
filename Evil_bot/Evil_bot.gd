extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector3(0,0,0)
# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()
func _ready():
	rng.randomize()

var damage = 0
#onready var material = $MeshInstance.get_surface_material(0)
#onready var color = material.albedo_color

func hit(direction):
	print("AI!")
	if damage < 1:
		damage += 0.1
			# mat1.albedo_color = Color("5f2121")
			
		#material.albedo_color = Color(color.r, color.g - damage, color.b - damage)
			# 48d4ff
	else:
		move_and_slide(-direction*5000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
var move_force = 20
func _process(delta):
	if rng.randf_range(-10.0, 10.0) < 5:
		velocity -= move_force* global_transform.basis.z
		
	if rng.randf_range(-10.0, 10.0) < 5:
		velocity += move_force* global_transform.basis.z

	if rng.randf_range(-10.0, 10.0) < 5:
		velocity -= move_force* global_transform.basis.x

	if rng.randf_range(-10.0, 10.0) < 5:
		velocity += move_force* global_transform.basis.x
	move_and_slide(velocity)
	velocity = Vector3(0,0,0)
	#add_central_force(velocity)
	#velocity = Vector3(0,0,0)
