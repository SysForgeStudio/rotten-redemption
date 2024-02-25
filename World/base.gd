extends StaticBody2D

const DAMAGE = 1
var base_health = 100.0

func _physics_process(delta):
	var overlapping_mobs = get_node("HurtBox").get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		base_health -= DAMAGE * overlapping_mobs.size() * delta
		print("Base: ", base_health)
