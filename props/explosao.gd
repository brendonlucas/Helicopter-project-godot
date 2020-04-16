extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer = 0
const KILL_TIMER = 2
onready var som_explosao = $explosao

# Called when the node enters the scene tree for the first time.
func _ready():
	som_explosao.play()


func _physics_process(delta):
	timer += delta
	if timer >= KILL_TIMER:
		queue_free()
