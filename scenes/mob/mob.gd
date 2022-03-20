extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Animation.playing = true

	var animation_names = $Animation.frames.get_animation_names()
	$Animation.animation = animation_names[randi() % animation_names.size()]


func _on_screen_exited():
	queue_free()
