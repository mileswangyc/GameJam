#extends Node2D
#
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("Shoot"):
		#var mouse_pos = get_global_mouse_position()
		#var total_distance = ($Spider.position.distance_to(mouse_pos))
		#var step_size = 100  # How far each segment goes
		#var steps = int(total_distance / step_size)
		#var direction = (mouse_pos - $Spider.position).normalized()
#
		#var line_instance = Line2D.new()
		#add_child(line_instance)
#
		#var current_pos = $Spider.position
		#var space_state = get_world_2d().direct_space_state
#
		#var hit = false
#
		#for i in range(steps):
			#line_instance.add_point(current_pos)
#
			#$Timer.start(0.01)  # You can adjust or remove the delay for instant drawing
			#await $Timer.timeout
#
			#var next_pos = current_pos + direction * step_size
#
			#var ray_params = PhysicsRayQueryParameters2D.new()
			#ray_params.from = current_pos
			#ray_params.to = next_pos
			#ray_params.exclude = [self]
			#ray_params.collision_mask = 1  # Adjust for your collision layers
#
			#var result = space_state.intersect_ray(ray_params)
#
			#if result:
				#print("Collision at:", result.position)
				#line_instance.add_point(result.position)
				#hit = true
				#break
			#else:
				#current_pos = next_pos
#
		## If nothing was hit, finish at mouse position
		#if not hit:
			#line_instance.add_point(mouse_pos)
			#print("No collision, line ended at mouse")
extends Node2D

<<<<<<< Updated upstream
var resultposvar = Vector2.ZERO
var lineinstance
var line_on = false
# Called when the node enters the scene tree for the first time.a
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Shoot") and line_on == false:
		line_on = true
		var mousedir = 250*(get_global_mouse_position()- $Spider.global_position).normalized()
		lineinstance = $Line2D
		
		
		var spacestate = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create($Spider.global_position, $Spider.global_position + mousedir * 10, 0xFFFFFFFF,[$Spider.get_rid()])
		var result = spacestate.intersect_ray(query)
		if result:
			resultposvar = result.position
		for i in range(10):
			lineinstance.points = [$Spider.global_position, $Spider.global_position + mousedir * i]
			print("front",$Spider.global_position +mousedir * i)
			$Timer.start(delta)
=======
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Nothing happens at start-up yet.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# When the player presses the "Shoot" action (defined in Input Map)
	if Input.is_action_just_pressed("Shoot"):
		
		# Get the position of the mouse in world coordinates
		var mouse_pos = get_global_mouse_position()
		
		# Calculate the total distance from the spider to the mouse
		var total_distance = $Spider.position.distance_to(mouse_pos)
		
		# How far each segment of the line should go before checking collision
		var step_size = 100  
		
		# Calculate how many segments we need to reach the target
		var steps = int(total_distance / step_size)
		
		# Get the direction from spider to mouse as a unit vector (length 1)
		var direction = (mouse_pos - $Spider.position).normalized()

		# Create a new Line2D node that we'll use to draw the web line
		var line_instance = Line2D.new()
		add_child(line_instance)  # Add the Line2D to the scene

		# Start at the spider's position
		var current_pos = $Spider.position
		
		# Access the 2D physics space for doing raycasts (collision checks)
		var space_state = get_world_2d().direct_space_state

		# Keep track of whether we hit anything
		var hit = false

		# Loop through the number of segments needed to reach the target
		for i in range(steps):
			# Add the current position as a point in the line
			line_instance.add_point(current_pos)

			# Optional: wait a tiny bit to draw segments one by one
			$Timer.start(0.01)
>>>>>>> Stashed changes
			await $Timer.timeout
			

<<<<<<< Updated upstream
			if i == 9 and not result:
				for l in range(11):
					var finalspot = $Spider.global_position + mousedir * 10
					lineinstance.points = [$Spider.global_position, finalspot - mousedir * l]
					print("Back: ",finalspot - mousedir * l)
					$Timer2.start(0.03); await $Timer2.timeout
					if l == 10:
						line_on = false
						
			
	if resultposvar != Vector2.ZERO:
		lineinstance.points = [$Spider.global_position, resultposvar]
	#if Input.is_action_pressed("Shoot") and line_on == true:
		#for p in range(10):
			#lineinstance.points = [resultposvar - p * resultposvar - $Spider.global_position]
			#$Timer.start(0.03); await $Timer.timeout
			#if p == 9:
				#break
			
			
		
=======
			# Calculate where the next segment will end
			var next_pos = current_pos + direction * step_size

			# Set up the raycast to check from current to next position
			var ray_params = PhysicsRayQueryParameters2D.create(current_pos, next_pos, 0xFFFFFFFF, [$Spider.get_rid()])

			# Perform the raycast
			var result = space_state.intersect_ray(ray_params)

			# If the ray hits something
			if result:
				print("Collision at:", result.position)
				var static_instance = StaticBody2D.new()
				add_child(static_instance)
				static_instance.position = result.position
				print("StaticBody2D position",static_instance.position)
				# Add the collision point as the final point in the line
				line_instance.add_point(result.position)
				hit = true
				break  # Stop drawing more segments — we hit something

			else:
				# No collision — move to the next point
				current_pos = next_pos

		# If no collision occurred at all, draw the final point at the mouse
		if not hit:
			line_instance.add_point(mouse_pos)
			print("No collision, line ended at mouse")
>>>>>>> Stashed changes
