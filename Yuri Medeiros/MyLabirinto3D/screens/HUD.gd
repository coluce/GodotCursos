extends CanvasLayer

onready var txtGeral: Label = get_node("txtGeral")
onready var txtTempo: Label = get_node("trtTTempo/lblTempo")
onready var btnReinicio: Button = get_node("btnReinicio")
onready var tmrTempoJogo: Timer = get_node("tmrTempoJogo")

signal perdeu
signal reinicia
signal fim_de_jogo

func _ready():
	txtGeral.text = ''
	btnReinicio.hide()
	
func _physics_process(delta):
	txtTempo.text = str(int(tmrTempoJogo.time_left))

func _on_tmrTempoJogo_timeout():
	emit_signal("perdeu")

func _on_btnReinicio_button_up():
	emit_signal("reinicia")

func perde():
	$AudioPerde.play()
	txtGeral.text = 'Perdeu playboy!'
	btnReinicio.show()
	tmrTempoJogo.stop()
	emit_signal("fim_de_jogo")
	
func ganha():
	$AudioGanha.play()
	txtGeral.text = 'Ganhou!'
	btnReinicio.show()
	tmrTempoJogo.stop()
	emit_signal("fim_de_jogo")
