extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree

# gloabal vars
var direction: Vector2 = Vector2.ZERO


# CONSTANTS
var speed = 0.1
var step_timer = 0
var max_step_timer = 0.04

func _ready():
	animation_tree.active = true
	
func _process(delta):
	update_animation_parameters()

func _physics_process(delta):		
	if (step_timer >= max_step_timer):
		move_and_collide(velocity)
		step_timer = 0
	else:
		step_timer += delta	

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
	
