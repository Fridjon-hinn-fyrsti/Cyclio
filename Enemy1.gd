extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func hit(force):
	move_and_slide(-force*1000)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
