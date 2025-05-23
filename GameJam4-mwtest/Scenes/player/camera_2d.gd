extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = -2713


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = %Spider.position.x
	if position.x < -2713:
		position.x = -2713
		
	if position.x > 3188:
		position.x = 3188
