extends Area2D

var velocity = 400
var direction = Vector2(0, -1) setget set_direction
export var distance_range: int = 250
onready var start_position : Vector2 = global_position

var is_active: bool = true

func _process(delta):
	if is_active:
		if global_position.distance_to(start_position) >= distance_range:
			explode()
			
		translate(direction * velocity * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func set_direction(value: Vector2):
	direction = value	
	rotation = direction.angle()

func explode():
	$SmokeParticles.emitting = false
	is_active = false
	$Sprite.visible = false
	$AnimationDestruction.play("explode")
	call_deferred("set_monitoring", false)
	call_deferred("set_monitorable", false)
	yield($AnimationDestruction, "animation_finished")			
	queue_free()

func _on_Bullet_body_entered(body):
	explode()
