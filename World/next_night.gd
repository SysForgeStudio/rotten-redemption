extends Node2D

var hours_base = 0
var hours_supplies = 0

func _ready():
	$CanvasLayer/Paper/ColorRectBase/LabelBaseHours.text = str(hours_base)
	$CanvasLayer/Paper/ColorRectSupplies/LabelSuppliesHours.text = str(hours_supplies)

func quit():
	get_tree().quit()

func next_night():
	pass

func add_supplies():
	pass

func repair_base():
	pass

func increase_hours_left(hours):
	var temp = Game.hours_left
	
	
	if(Game.hours_left > 0 and hours <= 12):
		hours += 1
		temp -= 1
		Game.hours_left = temp
	
	return hours

func decrease_base_hours(hours):
	var temp = Game.hours_left
	
	if(Game.hours_left < 12 and hours > 0): #fix issue here
		hours -= 1
		temp += 1
		Game.hours_left = temp

func _on_button_up_base_pressed():
	hours_base = increase_hours_left(hours_base)
	$CanvasLayer/Paper/ColorRectBase/LabelBaseHours.text = str(hours_base)


func _on_button_down_base_pressed():
	hours_base = decrease_base_hours(hours_base)
	$CanvasLayer/Paper/ColorRectBase/LabelBaseHours.text = str(hours_base)
