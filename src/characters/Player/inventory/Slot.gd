extends Panel


var ItemClass = preload("res://src/characters/Player/inventory/Item.tscn")
var item = null
var slot_index

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func pick_from_slot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null
	
func put_in_slot(new_item):
	item = new_item
	item.position = Vector2(0,0)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)

func initialize_item(name, quantity):
	if item == null:
		item = ItemClass.instance()
		add_child(item)
	
	item.set_item(name, quantity)
	
	
