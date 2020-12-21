extends KinematicBody

export var max_life = 5
var life = 0
export var velocity = 2

var damage = 10
var distance_attack = 3

onready var player = get_node("/root/Main/Player")
onready var body: MeshInstance = $Body

func change_color():
	pass

func _ready():
	life = max_life
	pass
	
func _physics_process(delta):
	#calcular a direcao do player
	var dir = (player.translation - translation).normalized()
	dir.y = 0
	
	#movimentacao
	move_and_slide(dir * velocity, Vector3.UP)
	
func toma_dano(dano):
	life -= dano
	change_color()
	if life <= 0:
		morre()
	
func morre():
	player.toma_pontos(max_life)
	queue_free()
	
func atacar():
	player.toma_dano(damage)

func _on_Timer_timeout():
	if translation.distance_to(player.translation) <= distance_attack:
		atacar()
