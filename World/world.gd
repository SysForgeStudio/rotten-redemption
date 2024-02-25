extends Node2D

func spawn_mob():
	var new_mob = preload("res://Mobs/mob.tscn").instantiate()
	get_node("Path2D/PathFollow2D").progress_ratio = randf()
	new_mob.global_position = get_node("Path2D/PathFollow2D").global_position
	add_child(new_mob)

func _on_world_timer_timeout():
	spawn_mob()
