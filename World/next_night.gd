extends Node2D

var hours_base = 0
var hours_supplies = 0

func _ready():
	$CanvasLayer/Paper/ColorRectBase/LabelBaseHours.text = str(hours_base)
	$CanvasLayer/Paper/ColorRectSupplies/LabelSuppliesHours.text = str(hours_supplies)

func _process(delta):
	$CanvasLayer/Paper/LabelMaxHours.text = "Hours left: " + str(Game.hours_left)

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

func decrease_hours_left(hours):
	var temp = Game.hours_left
	
	if(Game.hours_left <= 12 and hours > 0):
		hours -= 1
		temp += 1
		Game.hours_left = temp
		
	
	return hours

func _on_button_up_base_pressed():
	hours_base = increase_hours_left(hours_base)
	$CanvasLayer/Paper/ColorRectBase/LabelBaseHours.text = str(hours_base)

func _on_button_down_base_pressed():
	hours_base = decrease_hours_left(hours_base)
	$CanvasLayer/Paper/ColorRectBase/LabelBaseHours.text = str(hours_base)


func _on_button_up_supplies_pressed():
	hours_supplies = increase_hours_left(hours_supplies)
	$CanvasLayer/Paper/ColorRectSupplies/LabelSuppliesHours.text = str(hours_supplies)


func _on_button_down_supplies_pressed():
	hours_supplies = decrease_hours_left(hours_supplies)
	$CanvasLayer/Paper/ColorRectSupplies/LabelSuppliesHours.text = str(hours_supplies)
