extends Node2D

onready var actionBar = $ActionBarSlots
onready var slots = actionBar.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(slots.size()):
		#slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])

		slots[i].slot_index = i
	initialize_actionBar()



func initialize_actionBar():
	for i in range(slots.size()):
		if PlayerInventory.actionBar.has(i):
			slots[i].initialize_item(PlayerInventory.actionBar[i][0], PlayerInventory.actionBar[i][1])
