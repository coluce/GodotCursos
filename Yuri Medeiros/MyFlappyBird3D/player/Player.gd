extends RigidBody

var fly_last_time

func _ready():
	fly_last_time = OS.get_ticks_msec()
	$AudioTema.play()
	
func _physics_process(delta):	
	if Input.is_action_pressed("ui_voa"):
		$AudioBatendoAsas.play()
		linear_velocity.y = 300 * delta
		fly_last_time = OS.get_ticks_msec()


func _on_TimerFinish_timeout():
	var diff = fly_last_time - OS.get_ticks_msec()
	if diff < - 10000:
		get_tree().change_scene("res://interfaces/MainMenu.tscn")
