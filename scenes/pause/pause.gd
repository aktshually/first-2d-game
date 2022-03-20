extends CanvasLayer

func hide_children():
	$ConfirmSettings.hide()
	$QuitButton.hide()
	$ResumeButton.hide()
	$SettingsButton.hide()

func _on_settings_button_pressed():
	$ConfirmSettings.show()

func _on_resume_button_pressed():
	$ResumeButton.hide()
	$SettingsButton.hide()

	get_tree().paused = false


func _on_quit_button_pressed():
	$ConfirmQuit.show()


func _on_confirm_settings_confirmed():
	hide_children()
	get_tree().paused = false

	var _ok = get_tree().change_scene("res://scenes/settings/Settings.tscn")


func _on_confirm_quit_confirmed():
	hide_children()
	get_tree().paused = false

	var _ok = get_tree().change_scene("res://scenes/main/Main.tscn")
