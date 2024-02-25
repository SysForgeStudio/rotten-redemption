extends StaticBody2D

var damage = 50
var base_health = 100.0

signal base_health_depleted

func _physics_process(delta):
	var overlapping_mobs = get_node("HurtBox").get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		base_health -= damage * overlapping_mobs.size() * delta
	if base_health <= 0:
		damage = 0
		get_node("CollisionShape2D").disabled = true
		get_node("HurtBox/CollisionShape2D").disabled = true
