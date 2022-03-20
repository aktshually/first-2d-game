extends CanvasLayer

var config = ConfigFile.new()

func _ready():
	config.load("res://config/config.cfg")
	$IsMusicOn.pressed = config.get_value("Settings", "is_music_on")
	$SpawnFrequencyInput.value = config.get_value("Settings", "spawn_frequency")

func _on_close_button_pressed():
	var _ok = get_tree().change_scene("res://scenes/main/Main.tscn")

func _on_is_music_on_toggled(button_pressed: bool):
	config.set_value("Settings", "is_music_on", button_pressed)
	config.save("res://config/config.cfg")

func _on_spawn_frequency_input_value_changed(value: float):
	config.set_value("Settings", "spawn_frequency", value)
	config.save("res://config/config.cfg")
