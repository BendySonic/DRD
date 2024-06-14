extends Entity

@export var movement_speed: float= 60
@export var movement_acceleration: float
@export var movement_friction: float

@onready var animator = $AnimationTree
@onready var sprite = $Sprite2D

@onready var cur_state:String = "idle"
@onready var last_direction:int = 1

# TODO можно переделать на стейт машину res://core/stateMachine/
func _process(delta):
	var direction = Input.get_vector("movement_left", "movement_right", "movement_up", "movement_down")
	
	if direction != Vector2.ZERO:
		velocity = lerp(velocity, direction*movement_speed, movement_acceleration * delta)
		if cur_state != "moving":
			cur_state = "moving"
			animator.set("parameters/OneShot 2/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	else:
		velocity = lerp(velocity, Vector2.ZERO, movement_friction * delta)
		if cur_state != "idle":
			cur_state = "idle" 
			animator.set("parameters/OneShot 2/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT)
	
	if direction.x != last_direction and direction.x != 0:
		animator.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		get_tree().create_timer(0.1).timeout
		
		last_direction = direction.x
		if direction.x > 0:
			sprite.scale = Vector2(1, sprite.scale.y)
		elif direction.x < 0:
			sprite.scale = Vector2(-1, sprite.scale.y)
		
	move_and_slide()
