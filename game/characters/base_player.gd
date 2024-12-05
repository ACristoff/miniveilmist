extends CharacterBody2D
class_name BasePlayer

@onready var sprite: Sprite2D = $Sprite2D
@onready var camera: Camera2D = $Camera2D
@onready var cursor = $AttackCursor
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var attack_timer: Timer = $Timers/AttackTimer
@onready var cooldown_timer: Timer = $Timers/CooldownTimer
@onready var invul_timer: Timer = $Timers/InvulTimer

var SPEED: float = 300.0
var ATTACK: int = 8
var ATTACK_SPEED: float = 1.2
var HEALTH: int = 20

var face_right: bool = true
var attack_direction: Vector2 = Vector2.UP

var item_stack: Array = []

func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	#TODO Add case for controller related input
	if event is InputEventMouse:
		update_cursor(event)
	pass

func _physics_process(delta: float) -> void:
	##PLAYER MOVEMENT##
	#Change to controller compatible inputs when nicholas updates the controller-controller
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

func attack() -> void:
	pass



#TODO Split out the attack cursor as its own node?
func update_cursor(event):
	#Get mouse cursor relative to player
	#Smoothly rotate the aiming cursor towards mouse
	#Update attack_direction var
	
	#TODO create a case for controller input, right stick angle
	#Probably some better way to get center of screen but fuck it for now
	#get_viewport().size returns a Vector2i which doesn't play nice with a Vector2
	var center = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2)
	cursor.rotation = position.angle_to_point(event.position - center)
	attack_direction = cursor.rotation
	pass
