extends KinematicBody

var MOVE_SPEED = 15
const JUMP_FORCE = 20
const GRAVITY = 0.98
const MAX_FALL_SPEED = 30
var y_velo = 0

const H_LOOK_SENS = 0.6
const V_LOOK_SENS = 0.4


onready var cam = $Camera
var gun

func _ready():
	pass
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	
func _input(event):
	
	if event is InputEventMouseMotion:
		cam.rotation_degrees.x -= event.relative.y * V_LOOK_SENS
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x, -90, 90)
		rotation_degrees.y -= event.relative.x * H_LOOK_SENS
 

func _physics_process(delta):
	var is_moving = false
	var sprint = false

	MOVE_SPEED = 15
	
	var move_vec = Vector3()
	if Input.is_action_pressed("frente"):
		move_vec.z -= 1
		is_moving = true
		
	if Input.is_action_pressed("traz"):
		move_vec.z += 1
		is_moving = true
		
	if Input.is_action_pressed("direita") :
		move_vec.x += 1
		is_moving = true
		
	if Input.is_action_pressed("esquerda"):
		move_vec.x -= 1
		is_moving = true
	
	if Input.is_action_pressed("sprint"):
		sprint = true
		
	#animations
	
		
	
	
	var just_jumped = false
	var grounded = is_on_floor()
	
	if grounded and Input.is_action_just_pressed("pulo"):
		is_moving = false
		just_jumped = true
		y_velo = JUMP_FORCE
	
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	move_vec *= MOVE_SPEED
	move_vec.y = y_velo
	move_and_slide(move_vec, Vector3(0, 1, 0))
	y_velo -= GRAVITY

	if grounded and y_velo <= 0:
		y_velo = -0.1
	if y_velo < -MAX_FALL_SPEED:
		y_velo = -MAX_FALL_SPEED


	
