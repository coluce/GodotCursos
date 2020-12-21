extends Area2D

export var speed: = 100
var screen_size

signal pontua

func _ready():
	screen_size = get_viewport_rect().size
	pass

func _process(delta):
	
	var velocity = Vector2()
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1		

	#if Input.is_action_pressed("ui_right"):
	#	velocity.x += 1		
		
	#if Input.is_action_pressed("ui_left"):
	#	velocity.x -= 1		
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if velocity.y > 0:
			$AnimatedSprite.play("baixo")
		elif velocity.y < 0:
			$AnimatedSprite.play("cima")
	else:
		$AnimatedSprite.stop()
		
	self.position += velocity * delta
	
	self.position.y = clamp(self.position.y, 0, screen_size.y)
	

func _on_Player_body_entered(body):
	
	if body.name == "Ganha":
		emit_signal("pontua")
	else:
		$AudioStreamPlayer2D.play()
		
	volta() 
	
func volta() -> void:
	position.x = 320
	position.y = 696
