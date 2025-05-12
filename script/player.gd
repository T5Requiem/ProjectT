extends CharacterBody2D

@onready var hudBalls = get_node("../Camera/HUD/BallsLabel")
@onready var playerShape = $PlayerCollisionShape
@onready var playerAnimationSprite = $PlayerAnimationSprite

@onready var playerSize = playerShape.shape.size

@export var maxPlayerHealth: int = 100
@export var playerHealth: int = maxPlayerHealth
@export var movementSpeed: float = 50000.0
@export var gravity: float = 5000.0
@export var jumpForce: float = 100000.0
@export var isJumping: bool = false
@export var isMoving: bool = false
@export var collectedBalls: int = 0

var ready_to_move := false

func _ready() -> void:
	add_to_group("player")
	hudBalls.text = str(collectedBalls)

	await get_tree().process_frame
	ready_to_move = true

func _physics_process(delta: float) -> void:
	if !is_inside_tree():
		return

	if get_tree().paused:
		return

	isMoving = false
	var direction = Vector2.ZERO
	if Input.is_action_pressed("LEFT") and !Input.is_action_pressed("RIGHT"):
		if position.x > 0 + playerSize.x / 2:
			direction.x -= 1
		playerAnimationSprite.flip_h = true
		isMoving = true
	elif Input.is_action_pressed("RIGHT") and !Input.is_action_pressed("LEFT"):
		if position.x < 3834 * 2 - playerSize.x / 2:
			direction.x += 1
		playerAnimationSprite.flip_h = false
		isMoving = true
	
	direction = direction.normalized()
	velocity.x = direction.x * movementSpeed * delta
	
	if not is_on_floor():
		playerAnimationSprite.play("Idle")
		if Input.is_action_just_pressed("JUMP") and !isJumping:
			velocity.y = -jumpForce * delta
			isJumping = true
		velocity.y += gravity * delta
	else:
		if isMoving:
			playerAnimationSprite.play("Running")
		else:
			playerAnimationSprite.play("Idle")
		isJumping = false
		if Input.is_action_just_pressed("JUMP"):
			velocity.y = -jumpForce * delta
	
	if position.y > 1500:
		playerTakeDamage(maxPlayerHealth)

	if is_inside_tree() and is_instance_valid(self):
		move_and_slide()

func collectBalls() -> void:
	collectedBalls += 1
	hudBalls.text = str(collectedBalls)


func playerTakeDamage(damage: int) -> void:
	playerHealth -= damage
	if playerHealth <= 0:
		die()


func die() -> void:
	get_tree().reload_current_scene()
