extends Panel


var ItemClass = preload("res://src/characters/Player/inventory/Item.tscn")
var item = null
var slot_index
var slot_type

var selected_texture = preload("res://assets/user-interface/actionBar_selected_background.png")
var selected_style: StyleBoxTexture = null

var default_texture = preload("res://assets/user-interface/actionBar_background.png")
var default_style: StyleBoxTexture = null

enum SlotType {
	ACTIONBAR = 0,
	INVENTORY = 1,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	selected_style = StyleBoxTexture.new()
	selected_style.texture = selected_texture
	
	default_style = StyleBoxTexture.new()
	default_style.texture = default_texture

func refresh_style():
	print(PlayerInventory.current_item_slot)
	if SlotType.ACTIONBAR == slot_type and PlayerInventory.current_item_slot == slot_index:
		set("custom_styles/panel", selected_style)
	else: 
		set("custom_styles/panel", default_style)
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
	
	
