extends Area

var velocidade = 28
var dano = 1

func _ready():
	pass

func _physics_process(delta):
	translation += global_transform.basis.z
	#+ velocidade * delta
	pass

func _process(delta):	
	pass

func _on_Ammo_body_entered(body):
	if body.has_method("toma_dano"):
		body.toma_dano(dano)
		destroy()
		
func destroy():
	queue_free()
