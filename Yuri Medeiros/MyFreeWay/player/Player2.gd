extends Area2D

export var speed: = 100
var screen_size

signal pontua2

func _ready():
	screen_size = get_viewport_rect().size
	pass

func _process(delta):
	
	var velocity = Vector2()
	if Input.is_action_pressed("desce"):
		velocity.y += 1
		
	if Input.is_action_pressed("sobre"):
		velocity.y -= 1		

	#if Input.is_action_pressed("ui_right"):
	#	velocity.x += 1		
		
	#if Input.is_action_pressed("ui_left"):
	#	velocity.x -= 1		
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
		if velocity.y > 0:
			$AnimatedSprite.play("baixo")
		elif velocity.y < 0:
			$AnimatedSprite.play("cima")
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	
	position.y = clamp(position.y, 0, screen_size.y)

func _on_Player2_body_entered(body):
	if body.name == "Ganha":
		emit_signal("pontua2")
	else:
		$AudioStreamPlayer2D.play()
		
	volta()
	
func volta() -> void:
	position.x = 944
	position.y = 696
