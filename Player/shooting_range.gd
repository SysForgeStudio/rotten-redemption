extends Area2D

func _physics_process(delta):
	var enemies_in_sight = get_overlapping_bodies()
	if enemies_in_sight.size() > 0:
		var target = enemies_in_sight.front()
		var zombie_found = true
