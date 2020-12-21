extends Sprite

func _on_TimerDestroy_timeout():
	queue_free()
