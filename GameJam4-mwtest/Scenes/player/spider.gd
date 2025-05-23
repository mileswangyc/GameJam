extends CharacterBody2D

var new_pos: Vector2 = Vector2.ZERO
const SPEED = 500
const JUMP_VELOCITY = -700
var mouse_dir: Vector2 = Vector2.ZERO
var web: bool = false
var is_stuck: bool = false
var web_stuck_point: Vector2
var climb_speed: float = 1000


func _on_main_spider_is_stuck(stuck_point: Variant) -> void:
	web_stuck_point = stuck_point
	is_stuck = true

func _physics_process(delta: float) -> void:
	#Add the gravity.
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
		
	if is_stuck:
		if Input.is_action_pressed("WebScrollUp"):
			position = position.move_toward(web_stuck_point, climb_speed * delta)
		#print("Spider: ", global_position, " | Stuck: ", web_stuck_point)

		

	
		
	
	
	move_and_slide()
