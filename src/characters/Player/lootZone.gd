extends Area2D


var items_in_range = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_lootZone_body_entered(body):
	items_in_range[body] = body


func _on_lootZone_body_exited(body):
	if items_in_range.has(body):
		items_in_range.erase(body)
