extends Node2D

var hours_base = 0
var hours_supplies = 0

func _ready():
	$AnimationPlayer.play("fade_in")
	$CanvasLayer/Paper/ColorRectBase/LabelBaseHours.text = str(hours_base)
	$CanvasLayer/Paper/ColorRectSupplies/LabelSuppliesHours.text = str(hours_supplies)

func _process(delta):
	$CanvasLayer/Paper/LabelMaxHours.text = "Hours left: " + str(Game.hours_left)

func quit():
	get_tree().quit()

func next_night():
	repair_base()
	add_supplies()

func add_supplies():
	Game.supplies += hours_supplies * 50

func repair_base():
	var new_health = Game.base_health + (hours_base * 10)
	if(new_health > 200):
		new_health = 200
	
	Game.base_health = new_health

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


func _on_quit_game_pressed():
	quit()


func _on_next_night_pressed():
	next_night()
