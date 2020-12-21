extends Spatial

onready var Enemy = preload("res://enemy/Enemy.tscn")
onready var PowerUpVida = preload("res://objects/PowerUpVida.tscn")
onready var PowerUpAmmo = preload("res://objects/PowerUpAmmo.tscn")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	randomize()
	pass


func _on_HUD_perdeu():
	$TimerReinicio.start()

func _on_TimerReinicio_timeout():
	get_tree().reload_current_scene()

func _on_TimerTurns_timeout():
	$TimerEnemy.wait_time = rand_range(15.0, 45.0)
	$TimerAmmo.wait_time = rand_range(30.0, 55.0)
	$TimerLife.wait_time = rand_range(40.0, 55.0)
	pass

func _on_TimerEnemy_timeout():
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.translation.x = rand_range(-50,50)
	enemy.translation.y = 0
	enemy.translation.z = rand_range(-50,50)

func _on_TimerLife_timeout():
	var life = PowerUpVida.instance()
	add_child(life)
	life.translation.x = rand_range(-50,50)
	life.translation.y = 0
	life.translation.z = rand_range(-50,50)


func _on_TimerAmmo_timeout():
	var ammo = PowerUpAmmo.instance()
	add_child(ammo)
	ammo.translation.x = rand_range(-50,50)
	ammo.translation.y = 0
	ammo.translation.z = rand_range(-50,50)
