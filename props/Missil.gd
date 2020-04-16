extends Spatial

var BULLET_SPEED = 100

var BULLET_DAMAGE = 150

const KILL_TIMER = 10
var timer = 0

var hit_something = false
var explosao_scene = preload("res://props/explosao.tscn")
func _ready():
	$Area.connect("body_entered", self, "collided")
	

func _physics_process(delta):
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(forward_dir * BULLET_SPEED * delta)
	
	timer += delta
	if timer >= KILL_TIMER:
		queue_free()


func collided(body):
	
	# If we have not hit something already check if the body we collided with has the 'bullet_hit' method.
	# If it does, then call it, passing our global origin as the bullet collision point.
	if hit_something == false:
		if body.has_method("bullet_hit"):
			body.bullet_hit(BULLET_DAMAGE, self.global_transform.origin)
	
	# Set hit_something to true because we've hit an object and set free ourself.
	hit_something = true
	if body.name != "heli":
		exploder()
		
		queue_free()
		
func exploder():
	var clone = explosao_scene.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	#som_explosao.play()
	
	# Set the bullet's global_transform to that of the pistol spawn point (which is this node).
	clone.global_transform = self.global_transform
	
