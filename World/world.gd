extends Node2D

var spawn_time
var big_wave_start
var big_wave_initiated = false
var dawn
var is_paused = false

func _physics_process(delta):
	_game_start_fade()
	
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		$PauseMenu/CanvasLayer/PauseMenuBg.visible = true
	
	big_wave_start = get_node("WinTimer").get_time_left()
	dawn = get_node("WinTimer").get_time_left()
	get_node("CanvasLayer/BaseHealth").value = Game.base_health
	get_node("CanvasLayer/NightTimer").value = get_node("WinTimer").time_left
	
	if(big_wave_initiated == false):
		spawn_time = randf_range(0.6,2.5)
	get_node("WorldTimer").wait_time = spawn_time
	
	if(big_wave_start <= 150):
		get_node("AnimationPlayerBigWave").play("show_label")
		await get_tree().create_timer(5).timeout
		start_big_wave()
	
	if(dawn <= 20):
		dawn_light()
	
	if(get_node("Mobs").get_children().size() == 0) and Game.game_over == true:
		_screen_blackout()
		_change_scene()

func _spawn_mob():
	var new_mob = preload("res://Mobs/mob.tscn").instantiate()
	get_node("Path2D/PathFollow2D").progress_ratio = randf()
	new_mob.global_position = get_node("Path2D/PathFollow2D").global_position
	get_node("Mobs").add_child(new_mob)

func _apply_movement_on_children(node):
	for child in node.get_children():
		_apply_movement_on_children(child)
		if child.has_method("_change_movement_to_player"):
			child._change_movement_to_player()

func _on_world_timer_timeout():
	if Game.game_over == false:
		_spawn_mob()

func _on_base_base_health_depleted():
	_apply_movement_on_children(get_node("Mobs"))
	Game.game_over = true
	get_node("WinTimer").paused = true
	get_node("AnimationPlayerGameOver").play("show")
	_screen_blackout()
	_change_scene()

func _on_win_timer_timeout():
	Game.game_over = true

func _game_start_fade():
	get_node("AnimationPlayerFadeIn").play("fade_in")

func change_scene_to_main_menu():
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")

func start_big_wave():
	#play sound
	big_wave_initiated = true
	spawn_time = Game.big_wave
	await get_tree().create_timer(3).timeout
	big_wave_initiated = false

func dawn_light():
	get_node("Lights/AnimationPlayer").play("dawn")

func change_scene_to_next_night():
	get_tree().change_scene_to_file("res://World/next_night.tscn")


func _on_animation_player_fade_out_animation_finished(fade_out):
	if(Game.base_health > 0):
		change_scene_to_next_night()
	else:
		change_scene_to_main_menu()

func _screen_blackout():
	var color_tween = get_tree().create_tween()
	var screen = get_node("CanvasLayer/GameOver")
	screen.visible = true
	color_tween.tween_property(screen, "modulate",Color.BLACK,4)

func _change_scene():
	get_node("AnimationPlayerFadeOut").play("fade_out")

func _on_button_resume_pressed():
	get_tree().paused = false
	$PauseMenu/CanvasLayer/PauseMenuBg.visible = false

func _on_button_quit_pressed():
	get_tree().quit()
