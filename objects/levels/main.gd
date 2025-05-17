extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		var mouse_pos = get_global_mouse_position()
		var total_distance = $Spider.position.distance_to(mouse_pos)
		var step_size = 100  # How far each segment goes
		var steps = int(total_distance / step_size)
		var direction = (mouse_pos - $Spider.position).normalized()

		var line_instance = Line2D.new()
		add_child(line_instance)

		var current_pos = $Spider.position
		var space_state = get_world_2d().direct_space_state

		var hit = false

		for i in range(steps):
			line_instance.add_point(current_pos)

			$Timer.start(0.01)  # You can adjust or remove the delay for instant drawing
			await $Timer.timeout

			var next_pos = current_pos + direction * step_size

			var ray_params = PhysicsRayQueryParameters2D.new()
			ray_params.from = current_pos
			ray_params.to = next_pos
			ray_params.exclude = [self]
			ray_params.collision_mask = 1  # Adjust for your collision layers

			var result = space_state.intersect_ray(ray_params)

			if result:
				print("Collision at:", result.position)
				line_instance.add_point(result.position)
				hit = true
				break
			else:
				current_pos = next_pos

		# If nothing was hit, finish at mouse position
		if not hit:
			line_instance.add_point(mouse_pos)
			print("No collision, line ended at mouse")
