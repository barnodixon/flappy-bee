extends Node

@onready var hud = $HUD
@onready var obstacle_spawner = $ObstacleSpawner
@onready var menu_layer = $MenuLayer

const SAVE_FILE_PATH = "user://savedata.save"

@export var score: int = 0: set = set_score
var high_score = 0

func _ready():
	obstacle_spawner.obstacle_created.connect(self._on_obstacle_created)
	load_highscore()

func new_game():
	self.score = 0
	obstacle_spawner.start()

func player_score():
	self.score += 1
	

func set_score(new_score):
	score = new_score
	hud.update_score(score)
	
func _on_obstacle_created(obstacles):
	obstacles.connect("score", Callable(self, "player_score"))
	
func _on_player_died():
	game_over()
	
func game_over():
	obstacle_spawner.stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	
	if score > high_score:
		high_score = score
		save_highscore()
	
	menu_layer.init_game_over_menu(score, high_score)
	
func _on_menu_layer_start_game():
	new_game()
	
func save_highscore():
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	save_data.store_var(high_score)
	save_data.close()
	
func load_highscore():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		high_score = save_data.get_var()
		save_data.close()
