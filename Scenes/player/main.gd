extends Node2D

var resultposvar = Vector2.ZERO
var lineinstance
var line_on = false
# Called when the node enters the scene tree for the first time.
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
			await $Timer.timeout
			

<<<<<<< HEAD:Scenes/player/main.gd
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
		if $Spider.global_position.distance_to(stuck_point) < 100:
			
			print("Spider reached stuck point, can reshoot.")
			is_stuck = false  # Reset stuck state after reaching the point
			stuck_point = Vector2.ZERO  # Reset stuck point

	
=======
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
			
			
		
>>>>>>> d077b5bae1ccc62e43ba64d18803498661715ac7:objects/levels/main.gd
