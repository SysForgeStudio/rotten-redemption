extends Node2D

var hours_base = 0
var hours_supplies = 0

func _ready():
	get_node("CanvasLayer/Paper/BaseHours").max_value = Game.hours_left
	get_node("CanvasLayer/Paper/SuppliesHours").max_value = Game.hours_left

func quit():
	get_tree().quit()

func next_night():
	pass

func add_supplies():
	pass

func repair_base():
	pass

func _on_base_hours_value_changed(value):
	pass
