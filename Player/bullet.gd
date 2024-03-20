extends Area2D

var travelled_distance = 0
var shooting = false

func _physics_process(delta):
	const SPEED = 6000 
	const RANGE = 1700
	
	if shooting == true:
		var direction = Vector2.RIGHT.rotated(rotation) #(1,0)
		position -= direction * SPEED * delta
		
		travelled_distance += SPEED * delta
		if travelled_distance > RANGE:
			queue_free()

func shoot():
	shooting = true

func _on_timer_timeout():
	shooting = false
	get_node("Timer").wait_time = 0.4

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()
