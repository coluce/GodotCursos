extends CanvasLayer

signal perdeu

func _ready():
	$lblPerdeu.hide()

func atualiza_municao(value):
	$Municao/lblMunicao.text = str(value)
	
func atualiza_pontos(value):
	$Pontos/lblPontos.text = str(value)
	
func atualiza_vidas(value):
	$Vidas/lblVidas.text = str(value)

func perde():
	$Municao.hide()
	$Pontos.hide()
	$Vidas.hide()
	$lblPerdeu.show()
	emit_signal("perdeu")
