extends Node2D

signal score

const SPEED = 200

func _physics_process(delta):
	position.x += -SPEED * delta
	if global_position.x <= -200:
		queue_free()

func _on_score_area_body_exited(body):
	if body is Player:
		emit_signal("score")
