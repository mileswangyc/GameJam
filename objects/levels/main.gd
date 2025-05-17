extends Node2D

var current_line: Line2D = null  # Reference to the active line
var is_drawing: bool = false
var is_stuck: bool = false
var stuck_point: Vector2 = Vector2.ZERO  # Point where the web gets stuck
var scroll_speed: int = 10.0  # Speed of the web's movement when scrolling
signal spider_is_stuck(stuck_point)

func _process(delta: float) -> void:
	# Allow shooting only when not already drawing
	if Input.is_action_just_pressed("Shoot") and not is_drawing and not is_stuck:
		is_drawing = true
		# Remove old line if it exists
		if current_line and current_line.is_inside_tree():
			current_line.queue_free()

		# Create a new Line2D
		current_line = Line2D.new()
		$Spider.add_child(current_line)

		# Get positions
		var spider_pos = $Spider.global_position
		var global_mouse_pos = get_global_mouse_position()

		# Calculate direction and distance
		var direction = (global_mouse_pos - spider_pos).normalized()
		var total_distance = spider_pos.distance_to(global_mouse_pos)
		var step_size = 100
		var steps = int(total_distance / step_size)

		# Setup the space_state for raycasting
		var space_state = get_world_2d().direct_space_state
		var hit = false

		# Draw line and perform raycast
		for i in range(steps):
			var current_global_pos = $Spider.global_position + direction * step_size * i
			var next_global_pos = $Spider.global_position + direction * step_size * (i + 1)

			# Draw point relative to Spider
			var local_point = $Spider.to_local(current_global_pos)
			current_line.add_point(local_point)

			# Small delay for drawing effect
			$Timer.start(0.01)
			await $Timer.timeout

			# Perform raycast to check for collision
			var ray_params = PhysicsRayQueryParameters2D.new()
			ray_params.from = current_global_pos
			ray_params.to = next_global_pos
			ray_params.exclude = [self]
			ray_params.collision_mask = 1  # Adjust for your collision layers

			var result = space_state.intersect_ray(ray_params)

			if result:
				# If collision occurs, set stuck point and stop drawing
				stuck_point = result.position
				is_stuck = true
				print("Web stuck at: ", stuck_point)  # Debugging line
				# Set the line to only have two points (Spider and stuck point)
				var local_hit = $Spider.to_local(stuck_point)
				current_line.points = [$Spider.to_local(spider_pos), local_hit]
				break

		# If no hit, the line reaches the mouse position
		if not hit and not is_stuck:
			var final_pos = $Spider.global_position + direction * total_distance
			var local_final = $Spider.to_local(final_pos)
			current_line.add_point(local_final)

		is_drawing = false  # Allow the next shot

	# If the web is stuck, the Spider should move toward the stuck point and update the line
	if is_stuck and stuck_point != Vector2.ZERO:  # Only move if stuck_point is valid

		# Continuously update the line to reflect the new Spider position and stuck point
		spider_is_stuck.emit(stuck_point)
		if current_line:
			current_line.points = [$Spider.to_local($Spider.global_position), $Spider.to_local(stuck_point)]

		# If Spider reaches the stuck point, stop moving and allow shooting again
		if $Spider.global_position.distance_to(stuck_point) < 10:
			print("Spider reached stuck point, can reshoot.")
			is_stuck = false  # Reset stuck state after reaching the point
			stuck_point = Vector2.ZERO  # Reset stuck point

	
