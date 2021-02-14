extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#spawn evil bot
#	var evil_bot = preload("res://Evil_bot/Evil_bot.tscn")
#	for i in range(10):
#		var obj = evil_bot.instance()
#		obj.translation = Vector3(40,40,40)
#		add_child(obj)


# Called every frame. 'delta' is the elapsed time since the previous frame.
onready var planet = get_node("Planet")
func _process(delta):
	for child in get_children():
		if child is KinematicBody:
			var vec = (planet.translation - child.translation).normalized()
			child.move_and_slide(vec)
