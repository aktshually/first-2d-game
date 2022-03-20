extends Node


export(PackedScene) var mob_scene
export(PackedScene) var settings_scene

var score
var isMusicBeingPlayed
var config = ConfigFile.new()

enum Status {
	PLAYING
	NOT_PLAYING
}

export(int) var status = Status.NOT_PLAYING

func _ready():
	randomize()
	config.load("res://config/config.cfg")

	# Initializing game without starting the timer
	score = 0
	$HUD.update_score(score)
	$HUD/Message.show()

	$Pause.hide_children()

	if config.get_value("Settings", "is_music_on"):
		$BackgroundMusic.play()

	$MobTimer.wait_time = config.get_value("Settings", "spawn_frequency")

func _process(_delta):
	if Input.is_action_pressed("pause") and status == Status.PLAYING:
		get_tree().paused = true

		$Pause/ResumeButton.show()
		$Pause/SettingsButton.show()
		$Pause/QuitButton.show()

func new_game():
	status = Status.PLAYING

	$HUD/RestartButton.hide()
	$SettingsButton.hide()

	if not $BackgroundMusic.playing and config.get_value("Settings", "is_music_on"):
		$BackgroundMusic.play()

	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

	# Deleting old mobs at the beginning of a new game
	get_tree().call_group("mobs", "queue_free")


func on_game_over():
	status = Status.NOT_PLAYING
	$ScoreTimer.stop()
	$MobTimer.stop()

	$HUD.show_game_over()

	$BackgroundMusic.stop()
	$DeathMusic.play()



func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout():
	var new_mob = mob_scene.instance()

	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	new_mob.position = mob_spawn_location.position

	var direction = mob_spawn_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4) # Add some randomness
	new_mob.rotation = direction

	var mob_velocity = Vector2(rand_range(150, 250), 0)
	new_mob.linear_velocity = mob_velocity.rotated(direction)

	add_child(new_mob) # Spawn mob


func _on_settings_button_pressed():
	$HUD.queue_free()
	$SettingsButton.hide()

	var _ok = get_tree().change_scene("res://scenes/settings/Settings.tscn")
