extends Node2D

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
