# Script that manages all view areas
extends Node2D

@onready var up = $up
@onready var down = $down
@onready var left = $left
@onready var right = $right

var up_collisions = {}
var down_collisions = {}
var left_collisions = {}
var right_collisions = {}

var current_direction = Vector2.ZERO

func update_direction(direction: Vector2):
	current_direction = direction
	
func player_in_sight():	
	if (current_direction.y < 0):
		if (not up_collisions.is_empty()):
			return true
	if (current_direction.y > 0):
		if (not down_collisions.is_empty()):
			return true
	if (current_direction.x < 0):
		if (not left_collisions.is_empty()):
			return true
	if (current_direction.x > 0):
		if (not right_collisions.is_empty()):
			return true
			
	


func _on_up_body_entered(body):
	if (body.name == "player"):
		up_collisions[body] = true


func _on_up_body_exited(body):
	if (body in up_collisions):
		up_collisions.erase(body)


func _on_down_body_entered(body):
	if (body.name == "player"):
		down_collisions[body] = true

func _on_down_body_exited(body):
	if (body in down_collisions):
		down_collisions.erase(body)


func _on_left_body_entered(body):
	if (body.name == "player"):
		left_collisions[body] = true


func _on_left_body_exited(body):
	if (body in left_collisions):
		left_collisions.erase(body)


func _on_right_body_entered(body):
	if (body.name == "player"):
		right_collisions[body] = true


func _on_right_body_exited(body):
	if (body in right_collisions):
		right_collisions.erase(body)
