extends CanvasLayer

var tempo = 0

func _ready():
	pass

func _on_Timer_timeout():
	tempo += 1
	$Label.text = 'Time: ' + str(tempo)
