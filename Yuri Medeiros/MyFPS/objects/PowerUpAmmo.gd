extends Area


func _ready():
	pass

func _on_PowerUpAmmo_body_entered(body):
	if body.name == 'Player':
		body.toma_municao(10)
		queue_free()
