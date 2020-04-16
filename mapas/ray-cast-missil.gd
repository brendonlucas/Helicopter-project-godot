extends Spatial

# Variables for storing how much ammo is in the weapon, how much spare ammo this weapon has
# and how much ammo is in a full weapon/magazine.
var ammo_in_weapon = 100
var spare_ammo = 100
const AMMO_IN_MAG = 300
# How much damage does this weapon do
const DAMAGE = 4

# Can this weapon reload?
const CAN_RELOAD = true
# Can this weapon be refilled
const CAN_REFILL = true

# The name of the reloading animation.
const RELOADING_ANIM_NAME = "Rifle_reload"
# The name of the idle animation.
const IDLE_ANIM_NAME = "Rifle_idle"
# The name of the firing animation
const FIRE_ANIM_NAME = "Rifle_fire"

# Is this weapon enabled?
var is_weapon_enabled = false

# The player script. This is so we can easily access the animation player
# and other variables.
var player_node = null

func _ready():
	pass
