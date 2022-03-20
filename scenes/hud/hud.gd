extends CanvasLayer

signal start_game

export (PackedScene) var settings_scene

func show_message(text):
	$Message.text = str(text)
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")

	# Wait until 'timeout' event get called
	yield($MessageTimer, "timeout")

	$Message.text = "Dodge the\nCreeps!"
	$Message.show()

	# Create a one shot timer and wait for it to finish
	yield(get_tree().create_timer(2), "timeout")
	$RestartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_restart_button_pressed():
	$RestartButton.hide()
	emit_signal("start_game")

func _on_message_timer_timeout():
	$Message.hide()
