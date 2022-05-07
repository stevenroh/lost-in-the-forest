extends KinematicBody2D

export (int) var speed = 400
var motion = Vector2()

onready var animated_sprite = $AnimatedSprite

func cartesian_to_isometric(cartesian):
	var screen_pos = Vector2()
	screen_pos.x = cartesian.x - cartesian.y
	screen_pos.y = (cartesian.x + cartesian.y) / 2
	return screen_pos

func _physics_process(delta):
	var direction = Vector2()

	if Input.is_action_pressed("up"):
		animated_sprite.animation = "run_ne"
		direction += Vector2(0, -1)
	if Input.is_action_pressed("down"):
		animated_sprite.animation = "run_sw"
		direction += Vector2(0, 1)

	if Input.is_action_pressed("left"):
		animated_sprite.animation = "run_nw"
		direction += Vector2(-1, 0)
	if Input.is_action_pressed("right"):
		animated_sprite.animation = "run_se"
		direction += Vector2(1, 0)

	motion = direction.normalized() * speed
	motion = cartesian_to_isometric(motion)
	
	move_and_slide(motion)
