extends Area2D

signal hit

export var speed = 400
var screen_size

# Called when the game starts
func start(pos):
	position = pos
	show()
	$Collision.disabled = false

# Called when the node enters the scene tree for the first time
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called on each game frame
func _process(delta):
	var velocity = Vector2.ZERO

	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$Animation.play()
	else:
		$Animation.stop()

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0 , screen_size.y)

	if velocity.x != 0:
		$Animation.animation = "walk"
		$Animation.flip_v = false
		$Animation.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$Animation.animation = "up"
		$Animation.flip_v = velocity.y > 0


func _on_body_entered(_body: Node):
	hide()
	emit_signal("hit")

	# Disable the collision so 'hit' event is not called more than once
	$Collision.set_deferred("disabled", true)
