extends Sprite2D

const VELOCITY : float = -1.5
var background_width : float = 0 

var started = false

func _ready():
	background_width = texture.get_size().x * scale.x
	
func _process(_delta):
	if Input.is_action_just_pressed("jump"):
		started = true
	if started == true:
		position.x += VELOCITY
		attempt_reposition()

func attempt_reposition():
	if position.x < -background_width:
		position.x += 2 * background_width


func _on_player_died():
	set_process(false)
