extends Node2D

var item_name
var item_quantity


# Called when the node enters the scene tree for the first time.
func _ready():
	var rand_val = randi() % 4
	if rand_val == 0:
		item_name = 'axe'
	elif rand_val == 1:
		item_name = 'pickaxe'
	elif rand_val == 2:
		item_name = 'wood'
	else:
		item_name = 'woodstick'
	
	$TextureRect.texture = load("res://assets/Items/"+ item_name +".png")
	var stack_size = int(ItemDataReader.item_data[item_name]["stackSize"])
	item_quantity = randi() % stack_size + 1
	
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.text = String(item_quantity)
		
func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = String(item_quantity)
