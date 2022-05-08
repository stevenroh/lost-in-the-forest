extends Node2D

var item_name
var item_quantity


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		
func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = String(item_quantity)
	
func set_item(name, quantity):
	item_name = name
	item_quantity = quantity
	$TextureRect.texture = load("res://assets/Items/"+ item_name +".png")
	var stack_size = int(ItemDataReader.item_data[item_name]["stackSize"])
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.text = String(item_quantity)
