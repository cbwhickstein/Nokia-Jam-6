extends Node2D
@onready var escape = $escape
@onready var prison = $prison
@onready var game_over = $game_over
@onready var win = $win
@onready var start = $start
@onready var alert = $alert

@onready var sound_list = [false, escape, prison, game_over, win, start, alert]

enum state {
	nothing = 0,
	escape = 1,
	prison = 2,
	game_over = 3,
	win = 4,
	start = 5,
	alert = 6,
}
var current_state: state = state.nothing
var last_state: state = state.nothing

func _process(delta):
	if (current_state != last_state):
		if (last_state != state.nothing):
			sound_list[last_state].stop()
		sound_list[current_state].play()
		last_state = current_state
		



func _on_prison_finished():
	if (current_state == state.prison):
		prison.play()
		



func _on_escape_finished():
	if (current_state == state.escape):
		escape.play()
