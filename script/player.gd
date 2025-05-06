extends CharacterBody2D

@export var movementSpeed: float = 500.0

@onready var background = get_node("../Background")
@onready var playerSprite = $PlayerSprite

@onready var playerSize = playerSprite.texture.get_size() * playerSprite.scale

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("UP") and position.y > -1080*3+playerSize.y/2:
		direction.y -= 1
	if Input.is_action_pressed("DOWN") and position.y < 1080-playerSize.y/2:
		direction.y += 1
	if Input.is_action_pressed("LEFT") and position.x > 0+playerSize.x/2:
		direction.x -= 1
	if Input.is_action_pressed("RIGHT") and position.x < 3840*2-playerSize.x/2: 
		direction.x += 1
	
	velocity = direction * movementSpeed
	move_and_slide()
