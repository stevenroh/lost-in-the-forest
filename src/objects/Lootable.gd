extends KinematicBody2D

var ACCELERATION = 460
var MAX_SPEED = 225

var velocity = Vector2.ZERO
var item_name
var player = null
var is_being_loot = false

# Called when the node enters the scene tree for the first time.
func _ready():
	item_name = "axe"
	
func _physics_process(delta):
	if is_being_loot:
		var direction =  global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		var distance = global_position.distance_to(player.global_position)
		if distance < 4:
			PlayerInventory.add_item(item_name, 1)
			queue_free()
	velocity = move_and_slide(velocity, Vector2.UP)

func loot(body):
	player = body
	is_being_loot = true
