extends CanvasLayer

onready var barraVidas = get_node("BarraVida")
onready var barraXP = get_node("BarraXP")
onready var textoTesouro = get_node("LabelTesouro")

func _ready():
	pass

func atualiza_vidas(vidas):
	barraVidas.value = vidas
	
func atualiza_xp(meu_xp):
	barraXP.value = meu_xp
	
func atualiza_tesouros(tesouros):
	textoTesouro.text = "Tesouros encontrados: " + str(tesouros)
