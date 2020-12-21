extends Area


func _ready():
	pass

func _on_PowerUpVida_body_entered(body):
	if body.name == 'Player':
		body.toma_vida(10)
		queue_free()
