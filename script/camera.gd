extends Camera2D

@onready var player = get_node("../Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player.position.x > 960 and player.position.x < 3840*2-960):
		position.x = player.position.x
	if (player.position.y < 540 and player.position.y > -1080*3+540):
		position.y = player.position.y
