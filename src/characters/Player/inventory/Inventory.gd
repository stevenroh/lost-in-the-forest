extends Node2D

const SlotClass = preload("res://src/characters/Player/inventory/Slot.gd")
const ItemClass = preload("res://src/characters/Player/inventory/Item.tscn")

onready var inventory_slots = $GridContainer
var holding_item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slot_index = i
	initialize_inventory()

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.item:
					on_empty_slot_clicked(slot)
				else:
					if holding_item.item_name != slot.item.item_name:
						on_different_item_slot_clicked(event, slot)
					else:
						on_same_item_slot_clicked(slot)
			elif slot.item:
				on_slot_clicked(slot)

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
		
func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])
			
func on_empty_slot_clicked(slot: SlotClass):
	PlayerInventory.add_item_to_empty_slot(holding_item, slot)
	slot.put_in_slot(holding_item)
	holding_item = null
	print(PlayerInventory.inventory)
	
func on_different_item_slot_clicked(event: InputEvent, slot:SlotClass):
	var temp_item = slot.item
	slot.pick_from_slot()
	slot.put_in_slot(holding_item)
	PlayerInventory.remove_item(slot)
	PlayerInventory.add_item(holding_item.item_name, holding_item.item_quantity)
	

	holding_item = temp_item
	holding_item.global_position = event.global_position
	
func on_same_item_slot_clicked(slot:SlotClass):
	
	var stack_size = int(ItemDataReader.item_data[slot.item.item_name]['stackSize'])
	var can_be_added = stack_size - slot.item.item_quantity
	if can_be_added > holding_item.item_quantity:
		PlayerInventory.add_item_quantity(slot, holding_item.item_quantity)
		slot.item.add_item_quantity(holding_item.item_quantity)
		holding_item.queue_free()
		holding_item = null
	else:
		PlayerInventory.add_item_quantity(slot, can_be_added)
		slot.item.add_item_quantity(can_be_added)
		holding_item.decrease_item_quantity(can_be_added)

func on_slot_clicked(slot: SlotClass):
	PlayerInventory.remove_item(slot)
	holding_item = slot.item
	slot.pick_from_slot()
	holding_item.global_position = get_global_mouse_position()
