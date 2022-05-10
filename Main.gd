extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_TimeManager_toggle_day():
	print("Change to day")
	$AnimationPlayer.play_backwards("DayToNight")

func _on_TimeManager_toggle_night():
	print("Change to night")
	$AnimationPlayer.play("DayToNight")

