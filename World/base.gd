extends StaticBody2D

var damage = 1

signal base_health_depleted

func _physics_process(delta):
	var overlapping_mobs = get_node("HurtBox").get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		Game.base_health -= damage * overlapping_mobs.size() * delta
	
	if Game.base_health <= 0:
		get_node("BaseWalls").texture = load("res://Assets/city 1/base_broken.png")
		damage = 0
		get_node("CollisionShape2D").disabled = true
		get_node("HurtBox/CollisionShape2D").disabled = true
		base_health_depleted.emit()
