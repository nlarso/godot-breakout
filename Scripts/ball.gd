extends RigidBody2D

const SPEEDUP = 6
const MAXSPEED = 400

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Bricks"):
			body.queue_free()
		elif body.get_name() == "Paddle":
			var speed = get_linear_velocity().length()
			var direction = get_pos() - body.get_node("AnchorPoint").get_global_pos()
			var velocity = direction.normalized()*min(speed+SPEEDUP, MAXSPEED)
			set_linear_velocity(velocity)
	
	if get_pos().y > get_viewport_rect().end.y:
		queue_free()