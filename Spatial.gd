extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var trees = [preload("res://Trees/Tree1.tscn"),preload("res://Trees/Tree2.tscn"),preload("res://Trees/Tree3.tscn"),preload("res://Trees/Tree4.tscn"),preload("res://Trees/Tree5.tscn"),preload("res://Trees/Tree6.tscn")]
onready var planet = get_node("Planet")
var rng = RandomNumberGenerator.new()
onready var R = 100


func fix_angle(trans):
	var planet_vector = (trans.origin - planet.transform.origin).normalized()
	trans.basis.y = planet_vector
	trans.basis.z = trans.basis.y.rotated(trans.basis.x, deg2rad(90))
	trans.basis.x = trans.basis.y.cross(trans.basis.z)
	trans = trans.orthonormalized()
	return trans

func _ready():
	rng.randomize()
	for i in range(200):
		var theta1 = rng.randf_range(0, 2*PI)
		var theta2 = rng.randf_range(0, PI)
		var x = cos(theta1)*sin(theta2)*R
		var z = sin(theta1)*sin(theta2)*R
		var y = cos(theta2)*R
		var obj = trees[rng.randi()%len(trees)].instance()
		obj.translation = Vector3(x,y,z)
		obj.transform = fix_angle(obj.transform)
		var trans = obj.transform.basis
		var scale = 10
		obj.transform.basis = Basis(trans.x*scale, trans.y*scale, trans.z*scale)
		add_child(obj)
	#spawn evil bot
	var evil_bot = preload("res://Evil_bot/Evil_bot.tscn")
	for i in range(10):
		var obj = evil_bot.instance()
		obj.translation = Vector3(40,40,40)
		add_child(obj)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_children():
		if child is KinematicBody:
			var vec = (planet.translation - child.translation).normalized()
			child.move_and_slide(vec*delta*100)
		if child is RigidBody:
			var vec = (planet.translation - child.translation).normalized()
			child.add_central_force(vec*delta*1000)
