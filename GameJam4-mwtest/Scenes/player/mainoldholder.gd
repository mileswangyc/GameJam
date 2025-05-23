extends Node2D

@onready var staticmarker: StaticBody2D = $Marker
var resultposvar = Vector2.ZERO
var lineinstance
var line_on = false
var stopconstant = true
var result = {}
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	
	if Input.is_action_pressed("Shoot") and line_on == false:
		resultposvar = Vector2.ZERO
		stopconstant = true
		
		line_on = true
		var mousedir = 250 * (get_global_mouse_position()- $SpiderStandIn.global_position).normalized()
		#print(mousedir)
		lineinstance = $Line2D


		var spacestate = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create($SpiderStandIn.global_position, $SpiderStandIn.global_position + mousedir * 10, 0xFFFFFFFF,[$Spider.get_rid()])
		result = spacestate.intersect_ray(query)
		if result:
			resultposvar = result.position
		#print(result)
		for i in range(10):
			lineinstance.points = [($SpiderStandIn.position), ($SpiderStandIn.position + mousedir * i)]
			#print("front",$SpiderStandIn.global_position +mousedir * i)
			$Timer.start(delta)
			await $Timer.timeout
			if result:
				break
			if i == 9 and not resultposvar:
				for l in range(11):
					var finalspot = $SpiderStandIn.position + mousedir * 10
					lineinstance.points = [($SpiderStandIn.position), (finalspot - mousedir * l)]
					#print("Back: ",finalspot - mousedir * l)
					$Timer2.start(delta); await $Timer2.timeout
					if l == 10:
						line_on = false
	if resultposvar != Vector2.ZERO:
		Globals.webmiles = true 
		staticmarker.global_position = resultposvar
		var markertospider = staticmarker.global_position - $SpiderStandIn.global_position
		var length = markertospider.length()
		var angle = markertospider.angle()
		var angledeg = rad_to_deg(angle)
		$SpiderStandIn/DampedSpringJoint2D.length = length
		$SpiderStandIn/DampedSpringJoint2D.rotation_degrees = angledeg-90
		#print("length: ",length)
		#print("angle",angledeg-90)
			
			
						


	if resultposvar != Vector2.ZERO:
		if Input.is_action_just_pressed("Shoot") and line_on == true:
			Globals.webmiles = false
			var storedresult = resultposvar
			resultposvar = Vector2.ZERO
			stopconstant = false
			for p in range(10):
				#print("Bottom Code Triggered")
				#print("line on:", line_on)
				var pulldir = (storedresult - $SpiderStandIn.global_position)/9
				lineinstance.points = [to_local(storedresult - pulldir*p), to_local($SpiderStandIn.global_position)]
	
				$Timer.start(delta); await $Timer.timeout
				if p == 9:
					lineinstance.clear_points()
					line_on = false
					break
		elif stopconstant == true:
			lineinstance.points = [to_local($SpiderStandIn.global_position), to_local(resultposvar)]
			
