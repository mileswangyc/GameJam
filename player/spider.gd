extends CharacterBody2D

var new_pos: Vector2 = Vector2.ZERO
const SPEED = 500
const JUMP_VELOCITY = -500
var mouse_dir: Vector2 = Vector2.ZERO
var web: bool = false

#func shoot():
	#new_pos = global_position
	#for i in range(1000):	
		#line_instance.add_point(new_pos, i)
		#print(new_pos)
		#$Timer.start(0.001)
		#await $Timer.timeout
		#new_pos = line_instance.get_point_position(i) + mouse_dir 
		#print(i)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		mouse_dir = 40 * (get_global_mouse_position() - global_position).normalized()
		var line_instance = Line2D.new()
		add_child(line_instance)
		new_pos = position
		for i in range(20):	
			line_instance.add_point(new_pos, i)
			print(new_pos)
			$Timer.start(delta)
			await $Timer.timeout
			new_pos = line_instance.get_point_position(i) + mouse_dir 
			print(i)
		

	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

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
