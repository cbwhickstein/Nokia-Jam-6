# Script that manages all view areas
extends Node2D

@onready var up = $up
@onready var down = $down
@onready var left = $left
@onready var right = $right

var up_player_collisions = {}
var down_player_collisions = {}
var left_player_collisions = {}
var right_player_collisions = {}

var up_wall_collisions = {}
var down_wall_collisions = {}
var left_wall_collisions = {}
var right_wall_collisions = {}


var current_direction = Vector2.ZERO

func update_direction(direction: Vector2):
	current_direction = direction
	
func player_in_sight():	
	if (current_direction.y < 0 and up_wall_collisions.is_empty()):
		if (not up_player_collisions.is_empty()):
			return true
	if (current_direction.y > 0 and down_wall_collisions.is_empty()):
		if (not down_player_collisions.is_empty()):
			return true
	if (current_direction.x < 0 and left_wall_collisions.is_empty()):
		if (not left_player_collisions.is_empty()):
			return true
	if (current_direction.x > 0 and right_wall_collisions.is_empty()):
		if (not right_player_collisions.is_empty()):
			return true
			
	


func _on_up_body_entered(body):
	if (body.name == "player"):
		up_player_collisions[body] = true
	elif (body.name.contains("wall")):
		up_wall_collisions[body] = true


func _on_up_body_exited(body):
	if (body in up_player_collisions):
		up_player_collisions.erase(body)
	elif (body in up_wall_collisions):
		up_wall_collisions.erase(body)


func _on_down_body_entered(body):
	if (body.name == "player"):
		down_player_collisions[body] = true
	elif (body.name.contains("wall")):
		down_wall_collisions[body] = true

func _on_down_body_exited(body):
	if (body in down_player_collisions):
		down_player_collisions.erase(body)
	elif (body in down_wall_collisions):
		down_wall_collisions.erase(body)

func _on_left_body_entered(body):
	if (body.name == "player"):
		left_player_collisions[body] = true
	elif (body.name.contains("wall")):
		left_wall_collisions[body] = true


func _on_left_body_exited(body):
	if (body in left_player_collisions):
		left_player_collisions.erase(body)
	elif (body in left_wall_collisions):
		left_wall_collisions.erase(body)

func _on_right_body_entered(body):
	if (body.name == "player"):
		right_player_collisions[body] = true
	elif (body.name.contains("wall")):
		right_wall_collisions[body] = true

func _on_right_body_exited(body):
	if (body in right_player_collisions):
		right_player_collisions.erase(body)
	elif (body in right_wall_collisions):
		right_wall_collisions.erase(body)
