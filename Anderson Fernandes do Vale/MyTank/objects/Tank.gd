tool
extends KinematicBody2D

export var max_speed: = 100
export var max_shoot: = 3

#um PI rotaciona meia esfera
export var rotation_velocity: = PI

var Bullet = preload("res://objects/Bullet.tscn")
var Track = preload("res://objects/Track.tscn")
var acelleration = 0
var travel = 0

onready var muzzle: Position2D = $Barrel/Muzzle
onready var bullet_group = 'bullet_group_' + str(self)

export(int, 'Big Red', 'Blue', 'Dark', 'Dark Large', 'Green', 'Huge', 'Red', 'Sand') var body_skin: int = 0 setget set_body_skin
export(int, 'Blue', 'Dark', 'Green', 'Red', 'Sand') var barrel_skin: int = 0 setget set_barrel_skin

var body_skins = [
	'res://sprites/tankBody_bigRed.png',	
	'res://sprites/tankBody_blue.png',	
	'res://sprites/tankBody_dark.png',
	'res://sprites/tankBody_darkLarge.png',		
	'res://sprites/tankBody_green.png',	
	'res://sprites/tankBody_huge.png',	
	'res://sprites/tankBody_red.png',	
	'res://sprites/tankBody_sand.png'	
]

var barrel_skins = [
	'res://sprites/tankBlue_barrel1.png',	
	'res://sprites/tankDark_barrel1.png',	
	'res://sprites/tankGreen_barrel1.png',	
	'res://sprites/tankRed_barrel1.png',	
	'res://sprites/tankSand_barrel1.png'
]

func set_body_skin(value):
	body_skin = value
	if Engine.editor_hint:
		update()

func set_barrel_skin(value):
	barrel_skin = value	
	if Engine.editor_hint:
		update()

func _draw():
	$SpriteBody.texture = load(body_skins[body_skin])
	$Barrel/Sprite.texture = load(barrel_skins[barrel_skin])
	
func _ready():
	randomize()
	$Barrel/SpriteFire.visible = false	

func _process(delta):	
	
	if Engine.editor_hint:
		return
			
	move_direction(delta)	
	look_direction(delta)
	shoot()	

func look_direction(delta) -> void:
	$Barrel.look_at(get_global_mouse_position())

func shoot() -> void:
	if Input.is_action_just_released("ui_shoot"):			
		if get_tree().get_nodes_in_group(bullet_group).size() < max_shoot:
			var bullet = Bullet.instance()
			bullet.global_position = muzzle.global_position
			bullet.direction = Vector2(cos($Barrel.global_rotation), sin($Barrel.global_rotation)).normalized()
			bullet.add_to_group(bullet_group)
			get_parent().add_child(bullet)
			$Barrel/AnimationFire.play("Fire")

func paint_track(delta, move):
	travel += move.length() * delta
	if travel > $SpriteBody.texture.get_size().y:
		travel = 0
		var track = Track.instance()
		track.global_position = self.global_position
		track.rotation = self.rotation
		track.z_index = self.z_index - 1
		$"../".add_child(track)	

func move_direction(delta):
	
	var direction = 0
	var rotation_angle = 0

	if Input.is_action_pressed("ui_right"):
		rotation_angle += 1
	if Input.is_action_pressed("ui_left"):	
		rotation_angle -= 1
		
	if Input.is_action_pressed("ui_down"):
		direction -= 1
	if Input.is_action_pressed("ui_up"):	
		direction += 1	
		
	rotate(rotation_velocity * delta * rotation_angle)
	
	acelleration = lerp(acelleration, max_speed * direction, 0.03)
	
	#mover, colidindo e esarrando nos objetos
	var move = move_and_slide(Vector2(cos(rotation), sin(rotation)) * acelleration)
	paint_track(delta, move)	
