extends Node2D

func _on_play_button_pressed():
	_screen_blackout()
	_change_scene()
	Game.base_health = 200
	Game.game_over = false

func _on_quit_button_pressed():
	get_tree().quit()

func _screen_blackout():
	var color_tween = get_tree().create_tween()
	var screen = get_node("CanvasLayer/NextScene")
	screen.visible = true
	color_tween.tween_property(screen, "modulate",Color.BLACK,4)

func _change_scene():
	get_node("AnimationPlayer").play("fade")
	
func _on_animation_player_animation_finished(fade):
	get_tree().change_scene_to_file("res://World/world.tscn")

func _on_htp_button_pressed():
	get_node("Popup").visible = true

func _on_close_button_pressed():
	get_node("Popup").visible = false
