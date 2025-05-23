extends CharacterBody2D

var calcvelo: Vector2 = Vector2.ZERO
var maxspeed = 750.0
var accel = 1500.0
var decel = 2000.0
var aircontrol = 1.3
var jumpheight = -1200.0
var gravity = 1800.0
var extrajtime = 0.1  
var buffer = 0.1  
var oldpos: Vector2 = Vector2.ZERO
var extrajtimer = 0.0
var buffer_timer = 0.0

func _physics_process(delta: float) -> void:
	print("real:     ",velocity)
	if Globals.webmiles == true:
		velocity = Vector2.ZERO
		global_position = %SpiderStandIn.global_position
		var newpos = position
		Globals.calcvelo = Vector2(newpos-oldpos)  
		oldpos = position
		print("calc:",Globals.calcvelo)
		return
	if Globals.webmiles == false:
		Globals.newvelo = velocity
		velocity += Globals.calcvelo * 70
		Globals.calcvelo = Vector2(0,0)
		
	if not is_on_floor():
		velocity.y += gravity * delta
		extrajtimer -= delta	
	buffer_timer -= delta
	
	var input_dir = Input.get_axis("Left", "Right")
	if is_on_floor():
		extrajtimer = extrajtime
		
		if input_dir != 0:
			velocity.x = move_toward(velocity.x, input_dir * maxspeed, accel * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, decel * delta)
		
		if Input.is_action_pressed("Up") or buffer_timer > 0:
			velocity.y = jumpheight
			buffer_timer = 0.0
	else:
		if input_dir != 0:
			velocity.x = move_toward(velocity.x, input_dir * maxspeed, accel * aircontrol * delta)

		if Input.is_action_just_pressed("Up"):
			buffer_timer = buffer

	move_and_slide()

	
