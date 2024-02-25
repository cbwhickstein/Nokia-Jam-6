# init script for the prision scene
extends Node2D

@onready var prison = $"."
@onready var guard = $characters/guard
@onready var music_player = $music_player

func _ready():
	guard.set_state(guard.StateEnum.guardBeforePrison)
	music_player.current_state = music_player.state.prison




func _on_player_start_level():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
