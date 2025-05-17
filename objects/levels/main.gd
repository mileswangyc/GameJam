extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		var mouse_dir = 40 * (get_global_mouse_position() - global_position).normalized()
		var line_instance = Line2D.new()
		add_child(line_instance)
		var new_pos = $Spider.position
		for i in range(20):	
			line_instance.add_point(new_pos, i)
			print(new_pos)
			$Timer.start(delta)
			await $Timer.timeout
			new_pos = line_instance.get_point_position(i) + mouse_dir 
			print(i)
