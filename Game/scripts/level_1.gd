extends Node2D
@onready var music_player = $player/music_player
@onready var guard = $guards/guard
@onready var guard_2 = $guards/guard2
@onready var guard_3 = $guards/guard3
@onready var guard_4 = $guards/guard4

var timer_counter: float = 0.0
var time_max: float = 0.3
var time_max_game_over = 2.5

var level_finished = false
var won = false
var play_game_over = false


	
	
	
	
func _process(delta):
	if (play_game_over):
		timer_counter += delta
		if (timer_counter > time_max_game_over):
			get_tree().change_scene_to_file("res://scenes/prison.tscn")
			
	elif (level_finished and not won):
		music_player.current_state = music_player.state.alert
		timer_counter += delta

		if (timer_counter > time_max):
			play_game_over = true
			music_player.current_state = music_player.state.game_over
			timer_counter = 0.0
			
	elif (level_finished and won):
		music_player.current_state = music_player.state.win
		play_game_over = true
			

func guard_player_seen():
	print("Game Over")
	level_finished = true
	won = false

func _on_player_level_won():
	level_finished = true
	won = true

func _on_guard_player_seen():
	guard_player_seen()

func _on_guard_2_player_seen():
	guard_player_seen()


func _on_guard_3_player_seen():
	guard_player_seen()


func _on_guard_4_player_seen():
	guard_player_seen()

