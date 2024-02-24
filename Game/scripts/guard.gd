extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree

# gloabal vars
var direction: Vector2 = Vector2.ZERO
var step_timer = 0
var collide

# CONSTANTS
var speed = 0.1
var max_step_timer = 0.04
var max_step_timer_normal = 0.04
var max_step_timer_slow = 0.08

# main functions

func _ready():
	animation_tree.active = true
	
func _process(delta):
	update_animation_parameters()

func _physics_process(delta):		
	behavior()
	
	if (step_timer >= max_step_timer):
		collide = move_and_collide(velocity)
		step_timer = 0
	else:
		step_timer += delta	

# game logic
enum StateEnum {
	unknown,
	guardBeforePrison,
}
var state: StateEnum = StateEnum.unknown

func behavior():
	if (state == StateEnum.guardBeforePrison):
		# Let the guard walk from left to right repetedly
		if (direction == Vector2.ZERO): # Start condition for the prison guard
			direction = Vector2(-1, 0) # start walking left
			max_step_timer = max_step_timer_slow # let the guard walk slow
		if (collide): # mirror direction on collision
			collide = null
			direction = -direction
						
		velocity = direction
			

func set_state(new_state: StateEnum):
	state = new_state

# Animation functions

func update_animation_parameters():
	if (velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
		
	if (velocity != Vector2.ZERO):
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction
	

