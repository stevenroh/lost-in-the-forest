extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		$Inventory.visible = !$Inventory.visible
		$Inventory.initialize_inventory()