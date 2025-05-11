extends CharacterBody2D

@onready var background = get_node("../Background")
@onready var playerSprite = $PlayerSprite
@onready var hudBalls = get_node("../Camera/HUD/BallsLabel")

@onready var playerSize = playerSprite.texture.get_size() * playerSprite.scale

@export var maxPlayerHealth: int = 100
@export var playerHealth: int = maxPlayerHealth
@export var movementSpeed: float = 50000.0
@export var gravity: float = 5000.0
@export var jumpForce: float = 100000.0
@export var isJumping: bool = false
@export var balls: int = 0

var ready_to_move := false

func _ready() -> void:
	add_to_group("player")
	hudBalls.text = str(balls)

	await get_tree().process_frame
	ready_to_move = true

func _physics_process(delta: float) -> void:
	if !is_inside_tree():
		return

	if get_tree().paused:
		return

	var direction = Vector2.ZERO
	if Input.is_action_pressed("LEFT") and position.x > 0 + playerSize.x / 2:
		direction.x -= 1
	if Input.is_action_pressed("RIGHT") and position.x < 38402 - playerSize.x / 2: 
		direction.x += 1
	
	direction = direction.normalized()
	velocity.x = direction.x * movementSpeed * delta
	
	if not is_on_floor():
		if Input.is_action_just_pressed("JUMP") and !isJumping:
			velocity.y = -jumpForce * delta
			isJumping = true
		velocity.y += gravity * delta
	else:
		isJumping = false
		if Input.is_action_just_pressed("JUMP"):
			velocity.y = -jumpForce * delta
	
	if position.y > 1500:
		playerTakeDamage(maxPlayerHealth)

	if is_inside_tree() and is_instance_valid(self):
		move_and_slide()

func collectBalls() -> void:
	balls += 1
	hudBalls.text = str(balls)


func playerTakeDamage(damage: int) -> void:
	playerHealth -= damage
	if playerHealth <= 0:
		die()


func die() -> void:
	get_tree().reload_current_scene()
