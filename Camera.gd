extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animations = get_parent().get_node("AnimationPlayer")

func aim_down_sights(zoom_in):
	if zoom_in:
		animations.play("Aim_down_sights")
	else:
		animations.play_backwards("Aim_down_sights")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	transform = player.transform
#	transform.origin = transform.origin + transform.basis.z*10
