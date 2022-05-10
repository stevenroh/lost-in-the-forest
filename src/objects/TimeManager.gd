extends Node

signal toggle_day
signal toggle_night

export(bool) var enabled = false
export(int) var day_duration = 24

var day = true
var counter = 0

func _on_Timer_timeout():
	if not enabled:
		return

	counter += 1
	print("Count: " + str(counter))

	if counter == day_duration:
		counter = 0
		if day:
			emit_signal("toggle_night")
			day = false
		else:
			emit_signal("toggle_day")
			day = true
