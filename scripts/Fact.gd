class_name Fact
extends PanelContainer

const CONNECTING = Color.GREEN
const HOVERING = Color.BLUE

@export var value: String = ""
@onready var ctl = get_parent()

func _process(_delta):
	if ctl.connecting and ctl.connecting.a == self:
		modulate = CONNECTING
	elif ctl.hovering == self:
		modulate = HOVERING
	else:
		modulate = Color.WHITE
