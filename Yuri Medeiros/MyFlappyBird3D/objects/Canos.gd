extends Spatial


func _ready():
	randomize()
	translate(Vector3(0, rand_range(-3, 0),0))
	
func _physics_process(delta):
	translate(Vector3(0, 0, 4 * delta))

func colidiu(body):
	if body.name == 'Player':
		get_tree().change_scene("res://interfaces/MainMenu.tscn")

func _on_TimeDeleta_timeout():
	queue_free()
