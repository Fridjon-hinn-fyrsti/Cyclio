extends Spatial

onready var gunfire = get_node("Fire_gun")
onready var emptyclip = get_node("Empty_clip")
onready var reloadsound = get_node("Reload")
onready var animator = get_parent().get_node("AnimationPlayer")
onready var raycast = get_node("RayCast")
onready var bullet_counter = get_node("Bullet_counter")

var bullets = 30

func shoot():
	if not reloadsound.playing:
		if bullets > 0:
			if not animator.is_playing():
				bullets -= 1
				update_counter()
				gunfire.play()
				if raycast.is_colliding():
					var target = raycast.get_collider()
					if target.is_in_group("Enemies"):
						target.hit(raycast.get_collision_normal())
				animator.play("Fire_gun")
		else:
			if not emptyclip.playing:
				emptyclip.play()

func update_counter():
	bullet_counter.text = "%s/30" % bullets

func reload():
	if not reloadsound.playing:
		animator.play("Reload_gun")
		reloadsound.play()
		bullets = 30
		update_counter()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
