extends CharacterBody2D

# Subnodes
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var view = $view



# signals
signal player_seen

# gloabal vars
var direction: Vector2 = Vector2.ZERO
var step_timer = 0
var collide
var seeing_player: bool = false

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
	turning,
	horizontal_walking,
	vertical_walking,
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
		
	elif (state == StateEnum.turning):
		pass
		
	elif (state == StateEnum.horizontal_walking):
		# Let the guard walk horizontally from left to right
		# and send signal if player is in sight
		
		#init condition
		if (direction == Vector2.ZERO):
			direction = Vector2(-1, 0)
			max_step_timer = max_step_timer_normal
		
		# normal behavior
		
		# enable current view and disable others
		enable_view(direction)
		if (view.player_in_sight()):
			seeing_player = true
			player_seen.emit()
		else:
			seeing_player = false
		
		# check for wall and mirror direction
		if (collide):
			collide = null
			direction = -direction
		
		if (not seeing_player):
			velocity = direction
		else:
			velocity = Vector2.ZERO

func set_state(new_state: StateEnum):
	state = new_state

func enable_view(direction: Vector2):
	view.update_direction(direction)

# Animation functions

func update_animation_parameters():
	if (seeing_player):
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = false
		animation_tree["parameters/conditions/alert"] = true
	elif (velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
		animation_tree["parameters/conditions/alert"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
		animation_tree["parameters/conditions/alert"] = false
		
	if (velocity != Vector2.ZERO):
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/walk/blend_position"] = direction
	

