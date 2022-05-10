extends Node

signal toggle_day_night

export(bool) var enabled = false

var counter = 0

func _on_Timer_timeout():
	if not enabled:
		return

	counter += 1
	print("Count: " + str(counter))

	if counter % 10:
		emit_signal("toggle_day_night")
