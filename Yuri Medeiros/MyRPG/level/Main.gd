extends Node2D

var Bomba = preload("res://enemy/Bomba.tscn")
var Inimigo = preload("res://enemy/Inimigo.tscn")
var Tesouro = preload("res://objects/Tesouro.tscn")

var total_inimigos: = 0
var total_tesouros: = 0

func _ready():
	randomize()
	set_camera_limits()

func _on_Player_cria_bomba():
	var bomba = Bomba.instance()
	add_child(bomba)
	bomba.position.x = $Player.retorna_player_x()
	bomba.position.y = $Player.retorna_player_y()

func set_camera_limits():
	var map_size = $solo.get_used_rect()
	var cell_size = $solo.cell_size
	$Camera2D.limit_left = map_size.position.x * cell_size.x
	$Camera2D.limit_top = map_size.position.y * cell_size.y
	$Camera2D.limit_right = map_size.end.x * cell_size.x
	$Camera2D.limit_bottom = map_size.end.y * cell_size.y


func _on_TimerIninigos_timeout():
	if total_inimigos < 20:
		var inimigo = Inimigo.instance()
		add_child(inimigo)
		inimigo.position.x = rand_range(100, 600)
		inimigo.position.y = rand_range(100, 1000)
		total_inimigos += 1


func _on_TimerTesouros_timeout():
	if total_tesouros < 7:
		var tesouro = Tesouro.instance()
		add_child(tesouro)
		tesouro.position.x = rand_range(100, 600)
		tesouro.position.y = rand_range(100, 1000)
		total_tesouros += 1


func _on_Player_ganhou():
	$HUD/LabelTesouro.text = "Ganhou"
	$TimerReinicio.start()

func _on_TimerReinicio_timeout():
	get_tree().reload_current_scene()
