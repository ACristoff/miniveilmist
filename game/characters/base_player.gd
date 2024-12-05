extends CharacterBody2D
class_name BasePlayer

@onready var sprite = $Sprite2D
@onready var anim_player = $AnimationPlayer
@onready var attack_timer = $Timers/AttackTimer
@onready var cooldown_timer = $Timers/CooldownTimer
@onready var invul_timer = $Timers/InvulTimer

var SPEED: float = 300.0
var ATTACK: int = 8
var ATTACK_SPEED: float = 1.2
var HEALTH: int = 20

var face_right = true

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:	
	##PLAYER MOVEMENT##
	var horizontalDirection = Input.get_axis("ui_left", "ui_right")
	var verticalDirection = Input.get_axis("ui_up", "ui_down")
	#Flip the sprite whether moving left or right
	if horizontalDirection:
		sprite.flip_h = (horizontalDirection == -1)
		face_right = (horizontalDirection == 1)
	velocity.x = horizontalDirection * SPEED
	velocity.y = verticalDirection * SPEED
	#Normalize velocity when moving diagonally
	velocity = velocity.normalized() * min(velocity.length(), SPEED)
	#Idle
	if velocity.x == 0 and velocity.y == 0:
		pass
	move_and_slide()

func attack():
	pass