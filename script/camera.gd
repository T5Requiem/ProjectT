extends Camera2D

@onready var player = get_node("../Player")

func _ready() -> void:
	position = player.position


func _process(_delta: float) -> void:
	if (player.position.x > 960 and player.position.x < 3840*2-960):
		position.x = player.position.x
	if (player.position.y < 540 and player.position.y > -1080*3+540):
		position.y = player.position.y
