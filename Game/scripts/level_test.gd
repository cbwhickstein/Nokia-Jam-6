extends Node2D
@onready var guard = $guard

func _ready():
	guard.state = guard.StateEnum.horizontal_walking
	



func _on_guard_player_seen():
	print("Game Over")
	get_tree().change_scene_to_file("res://scenes/prison.tscn")
