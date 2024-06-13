extends Entity

@export var movement_speed: float= 60.0
@export var movement_acceleration: float
@export var movement_friction: float

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D

# TODO можно переделать на стейт машину res://core/stateMachine/
func _process(delta):
	var direction = Input.get_vector("movement_left", "movement_right", "movement_up", "movement_down")
	
	if direction != Vector2.ZERO:
		velocity = lerp(velocity, direction*movement_speed, movement_acceleration * delta)
		animation_player.play("moving")
	else:
		velocity = lerp(velocity, Vector2.ZERO, movement_friction * delta)
		animation_player.play("idle")
	sprite.flip_h = velocity.x < 0
	move_and_slide()
