extends CharacterBody2D
class_name Player

signal died

const SPEED : int = 130
const JUMP_VELOCITY : float = -300.0

var started = false
var dead : bool = false


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	if Input.is_action_just_pressed("jump"):
		start()
		
	if started == true:
		velocity.y += gravity * delta 	# Handle gravity.
		move_and_slide() 	# Enable movement.
		
		# Handle death.
		if dead == true:
			return
			
		#H Handle player input
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			
			
		# Handle movement animation
		if velocity.y < 0:
			animated_sprite_2d.play("jump")
			rotation += 0.01
		else: 
			animated_sprite_2d.play("idle")
			rotation -= 0.02
	
	

func start():
	started = true

func die():
	# Function to call when something kills the player. 
	dead = true
	animated_sprite_2d.play("die")
	emit_signal("died")
	collision_shape_2d.queue_free()
	
	
