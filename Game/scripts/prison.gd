# init script for the prision scene
extends Node2D

@onready var prison = $"."
@onready var guard = $characters/guard

func _ready():
	guard.set_state(guard.StateEnum.guardBeforePrison)


