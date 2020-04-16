extends Spatial
var anim
var motor
var heli_ligado = false
var current_anim
# Called when the node enters the scene tree for the first time.
func _ready():
	anim = get_node("AnimationPlayer")
	motor = get_node("som_motor")

func _process(delta):
	current_anim = anim.current_animation
	if heli_ligado and current_anim != "rotor":
		motor.play()
		anim.play("rotor")
	
func active_heli(value):
	heli_ligado = value
