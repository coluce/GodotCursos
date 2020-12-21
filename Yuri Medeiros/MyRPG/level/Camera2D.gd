extends Camera2D

onready var alvo = get_node("/root/Main/Player")

func _ready():
	pass

func _process(delta):
	position = alvo.position
