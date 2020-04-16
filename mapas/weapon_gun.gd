extends Spatial

const DAMAGE = 15

var bullet_scene = preload("res://props/bullet_gun.tscn")
const H_LOOK_SENS = 0.6
const V_LOOK_SENS = 0.4


func _ready():
	pass
	
func _input(event):
	if event is InputEventMouseMotion:
		self.rotation_degrees.x -= event.relative.y * -V_LOOK_SENS
		self.rotation_degrees.x = clamp(self.rotation_degrees.x, -80, 50)
		#rotation_degrees.y -= event.relative.x * H_LOOK_SENS
		
		
func fire_weapon():
	var clone = bullet_scene.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	
	# Set the bullet's global_transform to that of the pistol spawn point (which is this node).
	clone.global_transform = self.global_transform
	# The bullet is a little too small (by default), so let's make it bigger!
	clone.scale = Vector3(4, 4, 4)
	# Set how much damage the bullet does
	clone.BULLET_DAMAGE = DAMAGE


