extends Node

const SlotClass = preload("res://src/characters/Player/inventory/Slot.gd")
const ItemClass = preload("res://src/characters/Player/inventory/Item.gd")
const TOTAL_INVENTORY_SLOT = 20

var inventory = {
	0:["wood", 98],
	1:["wood", 98]
}

func remove_item(slot):
	inventory.erase(slot.slot_index)


func add_item_quantity(slot: SlotClass, quantity: int):
	inventory[slot.slot_index][1] += quantity 

func add_item(name, quantity):
	for item in inventory:
		if inventory[item][0] == name:
			var stack_size = ItemDataReader.item_data[name]["stackSize"]
			var can_be_added = stack_size - inventory[item][1]
			if can_be_added >= quantity:
				inventory[item][1] += quantity
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				return
			else:
				inventory[item][1] += can_be_added
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				quantity -= can_be_added
	for i in range(TOTAL_INVENTORY_SLOT):
		if !inventory.has(i):
			inventory[i] = [name, quantity]
			update_slot_visual(i, inventory[i][0], inventory[i][1])
			return

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]


func update_slot_visual(slot_index, item_name, quantity):
	var slot = get_tree().root.get_node("/root/Main/UserInterface/Inventory/GridContainer/Slot" + str(slot_index + 1))
	if slot.item != null:
		slot.item.set_item(item_name, quantity)
	else:
		slot.initialize_item(item_name, quantity)
