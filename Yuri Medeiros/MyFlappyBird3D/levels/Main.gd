extends Spatial


func _ready():
	pass


func _on_TimerCreateCano_timeout():
	$TimerCreateCano.start()
	var cano = preload("res://objects/Canos.tscn").instance()
	cano.translation.y = rand_range(0, 4)
	cano.translation.z = -33
	add_child(cano)
	
	
