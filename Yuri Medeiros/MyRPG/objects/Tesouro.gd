extends Area2D

onready var player = get_node("/root/Main/Player")


func _ready():
	var tipo_tesouro = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = tipo_tesouro[randi() % tipo_tesouro.size()]

func _on_Tesouro_body_entered(body):
	if body.name == "Player":
		player.toma_tesouro(1)
		player.toma_xp(10)
		queue_free()
