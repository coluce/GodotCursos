extends Area2D


func _ready():
	pass


func _on_Timer_timeout():
	queue_free()


func _on_Bomba_body_entered(body):
	if body.name != "Player":
		$explode.play()
		$AnimatedSprite.hide()
		$explosao.show()
		$explosao.animation = "default"
		$Timer.start()
		body.morre()
