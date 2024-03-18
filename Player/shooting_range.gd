extends Area2D

func _physics_process(delta):
	var enemies_in_sight = get_overlapping_bodies()

