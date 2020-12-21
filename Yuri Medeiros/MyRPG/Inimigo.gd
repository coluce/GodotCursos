extends KinematicBody2D

var speed = 125
var xp = 20
var dano = 20
var ataque_tempo = 1.0
var ataque_distancia = 100
var perseguicao_distancia = 400

onready var timer = $Timer
onready var alvo = get_node("/root/Main/Player")

func _ready():
	timer.wait_time = ataque_tempo

func _physics_process(delta):
	var distancia = position.distance_to(alvo.position)
	if distancia > ataque_distancia and distancia < perseguicao_distancia:
			var vel = (alvo.position - position).normalized()
			move_and_slide(vel * speed)


func _on_Timer_timeout():
	if position.distance_to(alvo.position) <= ataque_distancia:
		alvo.toma_dano(dano)
		
func morre():
	alvo.toma_xp(xp)
	queue_free()
