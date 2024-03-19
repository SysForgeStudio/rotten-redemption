extends Node2D

var spawn_time

func _physics_process(delta):
	_game_start_fade()
	
	get_node("CanvasLayer/BaseHealth").value = Game.base_health
	get_node("CanvasLayer/NightTimer").value = get_node("WinTimer").time_left
	
	spawn_time = randf_range(0.4,2.2)
	get_node("WorldTimer").wait_time = spawn_time
	
	if(get_node("Mobs").get_children().size() == 0) and Game.game_over == true:
		_change_scene_to_main_menu()

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
	_change_scene_to_main_menu()

func _on_win_timer_timeout():
	Game.game_over = true

func _game_start_fade():
	get_node("AnimationPlayerFadeIn").play("fade_in")

func _change_scene_to_main_menu():
	get_node("AnimationPlayerFadeOut").play("fade_out")

func _on_animation_player_fade_out_animation_finished(fade_out):
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")
	print("New scene")
