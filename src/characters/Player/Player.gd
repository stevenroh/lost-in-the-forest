extends KinematicBody2D

export (int) var speed = 400
var motion = Vector2()

onready var animated_sprite = $AnimatedSprite

var current_animation = "idle_"
var current_orientation = "s"


func cartesian_to_isometric(cartesian):
	var screen_pos = Vector2()
	screen_pos.x = cartesian.x - cartesian.y
	screen_pos.y = (cartesian.x + cartesian.y) / 2
	return screen_pos

func _physics_process(delta):
	var direction = Vector2()
	current_animation = "idle_"
	var orientation = ""

	if Input.is_action_pressed("up"):
		current_animation = "run_"
		orientation = orientation + "n"
		direction += Vector2(0, -1)
	if Input.is_action_pressed("down"):
		current_animation = "run_"
		if orientation != "n":
			orientation = orientation + "s"
		direction += Vector2(0, 1)

	if Input.is_action_pressed("left"):
		current_animation = "run_"
		orientation = orientation + "w"
		direction += Vector2(-1, 0)
	if Input.is_action_pressed("right"):
		current_animation = "run_"
		if orientation != "w":
			orientation = orientation + "e"
		direction += Vector2(1, 0)

	if orientation != "":
		current_orientation = orientation
		
	animated_sprite.animation = current_animation + current_orientation
	motion = direction.normalized() * speed
	
	# TODO - check which movement to keep but without modification seems better to me!
	# motion = cartesian_to_isometric(motion)
	
	move_and_slide(motion)
