extends KinematicBody2D

var speed: = 250
var vidas: = 100
var tesouros: = 0
var interactDist: = 80
var vel = Vector2()
var facingDir = Vector2()

var meu_xp: = 10

onready var raycast = $RayCast2D
onready var anim = $AnimatedSprite
onready var ui = get_node("/root/Main/HUD")

signal cria_bomba
signal ganhou

func _ready():
	$tema.play()
	ui.atualiza_vidas(vidas)
	ui.atualiza_xp(meu_xp)
	ui.atualiza_tesouros(tesouros)

func _physics_process(delta):
	vel = Vector2()
	if Input.is_action_pressed("ui_up"):
		vel.y -= 1
		facingDir = Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		vel.y += 1
		facingDir = Vector2(0, 1)
	if Input.is_action_pressed("ui_left"):
		vel.x -= 1
		facingDir = Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		vel.x += 1
		facingDir = Vector2(1, 0)
	vel = vel.normalized()
	
	move_and_slide(vel * speed, Vector2.ZERO)

	if Input.is_action_just_pressed("ui_bomba") and meu_xp >= 10:
		$poeBomba.play()
		toma_xp(-10)
		emit_signal("cria_bomba")

	if vel.x > 0:
		play_animation("direita")
	elif vel.x < 0:
		play_animation("esquerda")
	elif vel.y < 0:
		play_animation("cima")
	elif vel.y > 0:
		play_animation("baixo")
	elif facingDir.x == 1:
		play_animation("pdireita")
	elif facingDir.x == -1:
		play_animation("pesquerda")
	elif facingDir.y == -1:
		play_animation("pcima")
	elif facingDir.y == 1:
		play_animation("pbaixo")
		
func play_animation(anim_name):
	if anim.animation != anim_name:
		anim.play(anim_name)

func toma_tesouro(achado):
	$tesouro.play()
	tesouros += achado	
	ui.atualiza_tesouros(tesouros)
	if tesouros == 6:
		$ganhou.play()
		emit_signal("ganhou")
	
func toma_xp(quanto):
	meu_xp += quanto
	ui.atualiza_xp(meu_xp)
	
func toma_dano(dano):
	$dano.play()
	vidas -= dano
	ui.atualiza_vidas(vidas)
	if vidas <= 0:
		$morte.play()
		
func morre():
	get_tree().reload_current_scene()
	
func retorna_player_x():
	return position.x
	
func retorna_player_y():
	return position.y	


func _on_morte_finished():
	morre()
