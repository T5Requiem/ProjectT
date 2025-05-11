extends Area2D

@onready var player = get_node("../Player")

func _ready() -> void:
	$orb3.play("default")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player.collectCoin()
		queue_free()
