extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree

# signals
signal start_level
signal level_won

# gloabal vars
var direction: Vector2 = Vector2.ZERO
var collision: KinematicCollision2D = null

# CONSTANTS
var speed = 0.1
var step_timer = 0
var max_step_timer = 0.04

func _ready():
	animation_tree.active = true
	
func _process(delta):
	update_animation_parameters()

func _physics_process(delta):
	direction = Input.get_vector("left", "right", "up", "down")
	
	if (direction):
		velocity = direction
	else:
		velocity = Vector2.ZERO
		
	if (step_timer >= max_step_timer):
		collision = move_and_collide(velocity)
		step_timer = 0
	else:
		step_timer += delta	
		
	if (collision):
		match collision.get_collider().name:
			"front_bars":
				start_level.emit()
			"goal":
				level_won.emit()
		collision = null

func update_animation_parameters():
	if (velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
		
	if (direction != Vector2.ZERO):
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction
	

