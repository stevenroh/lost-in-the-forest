extends Node2D

const SlotClass = preload("res://src/characters/Player/inventory/Slot.gd")

onready var actionBar = $ActionBarSlots
onready var slots = actionBar.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(slots.size()):
		#slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		PlayerInventory.connect("active_item_updated", slots[i], "refresh_style")
		slots[i].slot_index = i
		slots[i].slot_type = SlotClass.SlotType.ACTIONBAR
	initialize_actionBar()



func initialize_actionBar():
	for i in range(slots.size()):
		if PlayerInventory.actionBar.has(i):
			slots[i].initialize_item(PlayerInventory.actionBar[i][0], PlayerInventory.actionBar[i][1])
