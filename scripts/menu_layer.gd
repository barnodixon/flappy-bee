extends CanvasLayer

signal start_game

@onready var start_message = $StartMenu/StartMessage
@onready var score_label = $GameOverMenu/VBoxContainer/ScoreLabel
@onready var high_score_label = $GameOverMenu/VBoxContainer/HighScore
@onready var game_over_menu = $GameOverMenu

var game_started = false
var tween

func _input(event):
	if event.is_action_pressed("jump") and !game_started:
		emit_signal("start_game")
		tween = get_tree().create_tween()
		tween.tween_property(start_message, "modulate:a", 0, 0.5)
		game_started = true

func init_game_over_menu(score, high_score):
	score_label.text = "Score: " + str(score)
	high_score_label.text = "Highscore: " + str(high_score)
	game_over_menu.visible = true

func _on_restart_pressed():
	get_tree().reload_current_scene()
