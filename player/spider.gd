extends CharacterBody2D

@onready var line_instance = $Line2D
var new_pos: Vector2
const SPEED = 500
const JUMP_VELOCITY = -500
var mouse_dir: Vector2 = Vector2.ZERO
var web: bool = false

func shoot():
	new_pos = global_position
	for i in range(100):	
		line_instance.add_point(new_pos, i)
		new_pos = line_instance.get_point_position(i) + mouse_dir 
		print(i)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		mouse_dir = (get_global_mouse_position() - global_position).normalized()
		shoot()
		

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction: #If Direction does not !=0
		velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/10)

	move_and_slide()
