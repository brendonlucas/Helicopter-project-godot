extends KinematicBody

var MOVE_SPEED = 30
const JUMP_FORCE = 30
#const GRAVITY = 0.98
const MAX_FALL_SPEED = 30
 
const H_LOOK_SENS = 0.3
const V_LOOK_SENS = 0.4

var y_velo = 0
onready var cam = $CameraGimbal
onready var camera = $CameraGimbal/InnerGimbal/Camera
#onready var lanca_missil = $"CameraGimbal/lanca_missil"
var missil_scene = preload("res://props/Missil.tscn")
onready var weapon_missil = get_parent().get_node("heli/lanca_missil")
onready var weapon_gun = get_parent().get_node("heli/weapon_gun")
var anin_move_heli

var timer_missil
var timer_gun
onready var som_missil = $"CameraGimbal/InnerGimbal/Audiomissil"
onready var som_gun = $"CameraGimbal/InnerGimbal/Audiogun"

	
var grabbed_object = null
const OBJECT_THROW_FORCE = 120


var active_heli = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	anin_move_heli = get_node("Helicoptero/RootNode gltf orientation matrix/RootNode model correction matrix/aab255878c444e24af63b2845ae2c519fbx/Node/RootNode/Animation_rotations")
	timer_missil = get_node("lanca_missil/Timer")
	timer_gun = get_node("lanca_missil/Timer")


func active_heli(value):
	active_heli = value

func _input(event):
	if event is InputEventMouseMotion and active_heli:
		cam.rotation_degrees.x -= event.relative.y * -V_LOOK_SENS
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x, -80, 50)
		rotation_degrees.y -= event.relative.x * H_LOOK_SENS
 
	
	
		
func _physics_process(delta):
	var idle = true
	var is_moving = false
	var sprint = false
	var fire = false
	var reload = false
	var frente = false
	var traz = false
	var direita = false
	var esquerda = false

	
	var move_vec = Vector3()
	if Input.is_action_pressed("frente") and active_heli:
		move_vec.z += 1
		frente = true
		is_moving = true
		idle = false
		
	if Input.is_action_pressed("traz") and active_heli:
		move_vec.z -= 1
		traz = true
		is_moving = true
		idle = false
		
	if Input.is_action_pressed("direita") and active_heli:
		move_vec.x -= 1
		direita = true
		is_moving = true
		idle = false
		
	if Input.is_action_pressed("esquerda") and active_heli:
		move_vec.x += 1
		esquerda = true
		is_moving = true
		idle = false
		
	if Input.is_action_pressed("subir") and active_heli:
		move_vec.y += 1
		is_moving = true
		
	if Input.is_action_pressed("descer") and active_heli:
		move_vec.y -= 1
		is_moving = true
	
	if active_heli == false and timer_missil.time_left == 0 and Input.is_action_pressed("fire_missil"):
		weapon_missil.fire_weapon()
		som_missil.play()
		timer_missil.start()
		
	if Input.is_action_pressed("fire") and active_heli == false:
		weapon_gun.fire_weapon() 
		#timer_gun.start()
		if !som_gun.is_playing():
			som_gun.play()
			

	if frente:
		anin_move_heli.play("inclinar_frente",0.2, true)
		
	if traz:
		anin_move_heli.play("inclinar_traz",0.2, true)
		
	if esquerda:
		anin_move_heli.play("inclinar_esquerda",0.2, true)
		
	if direita:
		anin_move_heli.play("inclinar_direita",0.2, true)
		
	if idle:
		anin_move_heli.play("idle",0.2, true)
		
	if sprint:
		MOVE_SPEED = 15
		
	var just_jumped = false
	var grounded = is_on_floor()
	
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)

	move_vec *= MOVE_SPEED
	#move_vec.y = y_velo
	move_and_slide(move_vec, Vector3(0, 1, 0))
	#y_velo -= GRAVITY

	if grounded and y_velo <= 0:
		y_velo = -0.1
	if y_velo < -MAX_FALL_SPEED:
		y_velo = -MAX_FALL_SPEED

