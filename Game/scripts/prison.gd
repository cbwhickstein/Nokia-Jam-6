# init script for the prision scene
extends Node2D

@onready var prison = $"."
@onready var guard = $characters/guard
@onready var music_player = $music_player

func _ready():
	guard.set_state(guard.StateEnum.guardBeforePrison)
	music_player.current_state = music_player.state.prison


