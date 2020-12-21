extends KinematicBody

# info player
var vidas: = 100
var pontos: = 0
var municao: = 20

# controle de camera
var sensibilidade: = 0.4
var angulo_minimo: = 0
var angulo_maximo: = 360

# acoes fisicas
var vel_moviento: = 5
var gravidade: = 1.62
var forca_pulo: = 4

# atalhos
onready var camera: Camera = get_node("Camera")
var velocidade: Vector3 = Vector3()
var movimento_mouse: Vector2 = Vector2()

onready var mira = get_node("Camera/arma/mira")
onready var Ammo = preload("res://objects/Ammo.tscn")
onready var hud = get_node("/root/Main/HUD")

func _ready():
	hud.atualiza_vidas(vidas)
	hud.atualiza_pontos(pontos)
	hud.atualiza_municao(municao)
	$AudioTheme.play()

func _input(event):
	if event is InputEventMouseMotion:
		movimento_mouse = event.relative
		
	if Input.is_action_just_pressed("ui_tiro"):
		atirar()
	
		
func _process(delta):
	# rotaciona a camera ao longo do eixo X
	camera.rotation_degrees -= Vector3(rad2deg(movimento_mouse.y), 0, 0) * sensibilidade * delta
	
	# limita a rotacao vertical com o angulo maximo e minimo
	camera.rotation_degrees.x - clamp(camera.rotation_degrees.x, angulo_minimo, angulo_maximo)

	# rotaciona a camera ao longo do eixo Y
	rotation_degrees -= Vector3(0, rad2deg(movimento_mouse.x), 0) * sensibilidade * delta
	
	#resetar mouse
	movimento_mouse = Vector2()
	
func _physics_process(delta):
	# reseta a velocidade em X e em Z
	velocidade.x = 0
	velocidade.z = 0
	
	var input = Vector2()
	
	# entradas do teclado
	if Input.is_action_pressed("ui_up"):
		input.y -= 1
	if Input.is_action_pressed("ui_down"):
		input.y += 1
	if Input.is_action_pressed("ui_left"):
		input.x -= 1
	if Input.is_action_pressed("ui_right"):
		input.x += 1
	
	# sem movimento na diagonal
	input - input.normalized()
	
	# obter direções
	var frente = global_transform.basis.z
	var direita = global_transform.basis.x
	
	# aplicar gravidade
	velocidade.y -= gravidade * delta
	velocidade.z = (frente * input.y + direita * input.x).z * vel_moviento
	velocidade.x = (frente * input.y + direita * input.x).x * vel_moviento
	
	# pular, sem pulo duplo
	if Input.is_action_just_pressed("ui_pulo") and is_on_floor():
		velocidade.y = forca_pulo
	
	velocidade = move_and_slide(velocidade, Vector3.UP)
	
func atirar():
	if municao > 0:
		$AudioTiro.play()
		var ammo = Ammo.instance()
		get_node("/root/Main").add_child(ammo)
		ammo.global_transform = mira.global_transform
		ammo.scale = Vector3.ONE
		municao -= 1
		hud.atualiza_municao(municao)
	

func toma_pontos(ganhou):
	pontos += ganhou
	$AudioEnemyDied.play()
	hud.atualiza_pontos(pontos)
	
func toma_vida(quanto):
	vidas += quanto
	$AudioLifeTaken.play()
	hud.atualiza_vidas(vidas)
	
func toma_dano(dano):
	vidas -= dano
	$AudioHit.play()
	hud.atualiza_vidas(vidas)
	if vidas == 0:
		morre()
		
func morre():
	hud.perde()
	
func toma_municao(quanto):
	municao += quanto
	$AudioAmmoTaken.play()
	hud.atualiza_municao(municao)
