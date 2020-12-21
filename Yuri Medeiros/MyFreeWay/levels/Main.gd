extends Node

const CarroModelo = preload("res://objects/Carros.tscn")

var pdevagar = [600, 544, 438, 324, 384, 216, 160]
var prapido = [488, 272, 104]

var score1: = 0
var score2: = 0

const score_target: int = 2

func _ready():
	$Button.hide()
	$tema.play()
	randomize()

func _on_TimerCarroRapido_timeout():
	var carro = CarroModelo.instance()
	add_child(carro)
	carro.position.x = -10
	carro.position.y = prapido[randi() % prapido.size()]
	carro.linear_velocity = Vector2(rand_range(700, 725), 0)


func _on_TimerCarroLento_timeout():
	var carro = CarroModelo.instance()
	add_child(carro)
	carro.position.x = -10
	carro.position.y = pdevagar[randi() % pdevagar.size()]
	carro.linear_velocity = Vector2(rand_range(300, 325), 0)

func end_game(titulo: String) -> void:
	$Button.show()
	$tema.stop()
	$resultado.text = titulo
	$ganhou.play()
	$TimerCarroLento.stop()
	$TimerCarroRapido.stop()

func _on_Player_pontua():
	if score1 < score_target:
		score1 += 1
		$ponto.play()
		$placar1.text = str(score1)
	else:
		end_game('P1 Ganhou!')	

func _on_Player2_pontua2():
	if score2 < score_target:
		score2 += 1
		$ponto.play()
		$placar2.text = str(score2)
	else:
		end_game('P2 Ganhou!')	


func _on_Button_pressed():
	
	$Button.hide()
	
	score1 = 0
	score2 = 0
	
	$placar1.text = '0'
	$placar2.text = '0'
	$resultado.text = ''
	
	$TimerCarroLento.start()
	$TimerCarroRapido.start()
	
	$Player.volta()
	$Player2.volta()
	
	$tema.play()
