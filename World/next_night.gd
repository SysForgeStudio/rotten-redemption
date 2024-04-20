extends Node2D

var hours_base = 0
var hours_supplies = 0

func _ready():
	Game.supplies_spending *= Game.night_count 
	$AnimationPlayer.play("fade_in")
	$CanvasLayer/Paper/ColorRectBase/LabelBaseHours.text = str(hours_base)
	$CanvasLayer/Paper/ColorRectSupplies/LabelSuppliesHours.text = str(hours_supplies)
	$CanvasLayer/Paper/LabelCurrentHealth.text = "Base shape: " + str(Game.base_health)
	$CanvasLayer/Paper/LabelCurrentSupplies.text = "Supplies left: " + str(Game.supplies)
	$CanvasLayer/Paper/LabelSuppliesSpending.text = "Supplies that will be spent: " + str(Game.supplies_spending)
	Game.hours_left = 12
	change_text()

func _process(delta):
	$CanvasLayer/Paper/LabelMaxHours.text = "Hours left: " + str(Game.hours_left)

func quit():
	get_tree().quit()

func next_night():
	repair_base()
	add_supplies()
	Game.night_count += 1
	Game.game_over = false
	Game.supplies -= Game.supplies_spending
	if(Game.supplies <= 0):
		Game.game_over = true
	_screen_blackout()
	_change_scene()

func change_text():
	if(Game.night_count == 2):
		%NightText.text = "Another endless battle for survival, hunger gnawing at me. I've heard rumors of a safe zone, too good to be true. The night feels suffocating; I yearn for companionship. Maybe redemption awaits in the form of a savior's arrival."
	if(Game.night_count == 3):
		%NightText.text = "I've scoured every corner for a sanctuary, but the world remains relentless. Still, amidst the chaos, I cling to hope. Perhaps redemption will come with the dawn."
	if(Game.night_count == 4):
		%NightText.text = "The darkness weighs heavy on my soul, but I refuse to surrender. I can hear them outside, hungry for flesh and blood. Still, I hold onto the belief that redemption is not beyond reach. Someone must be out there, someone who will come to my rescue."
	if(Game.night_count == 5):
		%NightText.text = "Five nights barricaded, five nights surviving. Hope is fading. I have to stay strong."

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

func _screen_blackout():
	var color_tween = get_tree().create_tween()
	var screen = get_node("CanvasLayer/Blackout")
	screen.visible = true
	color_tween.tween_property(screen, "modulate",Color.BLACK,4)

func _change_scene():
	get_node("AnimationPlayer").play("fade_out")

func change_scene_to_world():
	get_tree().change_scene_to_file("res://World/world.tscn")

func game_over():
	var label1 = get_node("CanvasLayer/LabelGameOver")
	var label2 = get_node("CanvasLayer/LabelGameOverText")
	label1.show()
	label2.show()
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")

func _on_animation_player_animation_finished(anim_name):
	if (anim_name == "fade_out"):
		if(Game.game_over == false):
			change_scene_to_world()
		else:
			game_over()
		
