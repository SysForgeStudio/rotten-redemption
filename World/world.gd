extends Node2D

var spawn_time

func _physics_process(delta):
	get_node("CanvasLayer/BaseHealth").value = Game.base_health
	get_node("CanvasLayer/NightTimer").value = get_node("WinTimer").time_left
	
	spawn_time = randf_range(0.6,2.4)
	get_node("WorldTimer").wait_time = spawn_time

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
	_spawn_mob()


func _on_base_base_health_depleted():
	_apply_movement_on_children(get_node("Mobs"))


func _on_win_timer_timeout():
	var color_tween = get_tree().create_tween()
	var screen = get_node("CanvasLayer/GameOver")
	color_tween.tween_property(screen, "modulate",Color.BLACK,5)
