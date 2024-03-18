extends Node2D

func _on_play_button_pressed():
	_screen_blackout()
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file("res://World/world.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _screen_blackout():
	var color_tween = get_tree().create_tween()
	var screen = get_node("CanvasLayer/NextScene")
	screen.visible = true
	color_tween.tween_property(screen, "modulate",Color.BLACK,4)
