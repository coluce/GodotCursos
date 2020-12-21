extends Spatial

var Caixa = preload("res://player/Ganhou.tscn")

func _ready():
	randomize()
	$AudioTema.play()

func _on_HUD_perdeu():
	$HUD.perde()	

func _on_HUD_reinicia():
	$Player.set_paused(false)
	get_tree().reload_current_scene()

func _on_TimerGeraCaixa_timeout():
	var caixa = Caixa.instance()
	caixa.translation.x = rand_range(-40,40)
	caixa.translation.y = 0
	caixa.translation.z = rand_range(-40,40)
	add_child(caixa)

func _on_HUD_fim_de_jogo():
	$Player.set_paused(true)
