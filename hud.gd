extends CanvasLayer

signal start_game

func update_score(score):
	$ScoreLabel.text = str(score)
	
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	
	$MessageLabel.text = "Dodge the Creeps"
	$MessageLabel.show()
	$Button.show()

func _on_button_pressed() -> void:
	$Button.hide()
	emit_signal("start_game")


func _on_message_timer_timeout() -> void:
	$MessageLabel.hide()
