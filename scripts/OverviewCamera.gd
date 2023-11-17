extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var deltaZoom = Vector2.ONE * .1
func _unhandled_input(ev):
	if ev is InputEventMouseButton and ev.pressed:
		match ev.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				zoom += deltaZoom
			MOUSE_BUTTON_WHEEL_DOWN:
				zoom -= deltaZoom
	
	if ev is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		position -= ev.relative / zoom

	
