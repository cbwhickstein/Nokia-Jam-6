extends Node2D
@onready var guard = $guard

func _ready():
	guard.state = guard.StateEnum.horizontal_walking
