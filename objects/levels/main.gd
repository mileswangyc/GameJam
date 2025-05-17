extends Node2D

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
			await $Timer.timeout
			

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
			
			
		
