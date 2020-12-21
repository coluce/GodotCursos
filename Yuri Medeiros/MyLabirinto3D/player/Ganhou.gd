extends Area

onready var hud = get_node("/root/Main/HUD")
onready var player = get_node("/root/main/Player")

func _ready():
	pass

func _on_Timer_timeout():
	queue_free()

func _on_Ganhou_body_entered(body):
	if body.name == 'Player':
		hud.ganha()
		queue_free()
