class_name FactManager
extends Control
## A class for handling operations on graphs of Facts

## Different varieties of connections, e.g. HAS, CONTAINS, etc.
enum ConnectionTypes {
	GENERIC ## Generic connection with no specific semantics
}

## Helper class for managing connections
class Connection:
	## The first member of the connection.
	## The semantics of member order depend on the connection type
	var a: Fact
	
	## The second member of the connection
	## The semantics of member order depend on the connection type
	var b: Fact
	
	## The nature of the connection between two facts
	var type: ConnectionTypes
	
	func _init(a: Fact, b: Fact = null, type = ConnectionTypes.GENERIC):
		self.a = a
		self.b = b
		self.type = type
		
	## Determine whether two connections are the same.
	## 
	## [param match_type] determines whether connection type will be taken into account (default: true)
	## [param bidirectional] determines whether connection a->b is equal to b->a (default: true) 
	static func eq(c1: Connection, c2: Connection, match_type = true, bidirectional = true):
		if not c1 or not c2: return false
		if match_type && c1.type != c2.type: return false
		if c1.a == c2.a && c1.b == c2.b: return true
		if bidirectional and c1.a == c2.b && c1.b == c2.a: return true
		return false 

## The list of connections in the graph
var connections: Array[Connection] = []

## State variable containing partially-constructed connection
var connecting: Connection

## State variable indicating a fact is being dragged
var dragging: Fact

## State variable contaning the currently hovered fact
var hovering: Fact

@export_file("*.tscn") var fact_prefab: String
@onready var _prefab = load(fact_prefab);

@export_group('String Properties')
@export var string_width: int = 4
@export var string_color: Color = Color.DARK_RED
@export var string_antialias: bool = true

## Add a connection to the fact graph
func add_connection(conn: Connection) -> Connection:
	remove_connection(conn)
	connections.append(conn)
	queue_redraw()
	return conn

## Add a fact to the fact graph
func add_fact(id: String, value: String):
	var fact = Fact.new()
	fact.name = id
	fact.value = value
	fact.z_index = 1
	fact.mouse_entered.connect(_hover_fact.bind(fact))
	fact.mouse_exited.connect(_unhover_fact.bind(fact))
	add_child(fact)
	
## Print a pretty representation of the graph to the console
func debug_print():
	print('Fact Graph:')
	for fact in get_facts():
		print('\t' + fact.name)
		for c in connections:
			if c.a == fact or c.b == fact:
				print('\t\t-> ' + (c.a.name if c.a != fact else c.b.name))

## Get a fact node from a string id
func get_fact(id: String):
	return get_children().filter(func(node): return node is Fact and node.name == id)

## Get the list of all facts in the graph
func get_facts():
	return get_children().filter(func(node): return node is Fact)

## Remove a connection from the fact graph
func remove_connection(conn: Connection):
	connections = connections.filter(func(other): return not Connection.eq(conn, other, false))
	queue_redraw()
	
## Draw the strings between connected facts
func _draw():
	for conn in connections:
		if connecting and Connection.eq(conn, connecting, false): continue
		draw_line(conn.a.position + conn.a.size / 2, conn.b.position + conn.b.size / 2, string_color, string_width, string_antialias)
	if connecting:
		var endpt = connecting.b.position + connecting.b.size / 2 if connecting.b else  get_global_mouse_position()
		draw_dashed_line(connecting.a.position + connecting.a.size / 2, endpt, string_color, string_width, string_width * 2, string_antialias)

## INTERNAL: Handle a fact being hovered over ([signal Fact.mouse_entered])
func _hover_fact(fact: Fact):
	if not dragging: hovering = fact
	if connecting: connecting.b = fact

## INTERNAL: Handle the mouse leaving a fact's boundaries ([signal Fact.mouse_exited])
func _unhover_fact(fact: Fact ):
	if not dragging and hovering == fact: hovering = null
	if connecting and connecting.b == fact: connecting.b = null
	
func _ready():
	for fact in get_facts():
		fact.z_index = 1 if fact.z_index == 0 else null
		fact.mouse_entered.connect(_hover_fact.bind(fact))
		fact.mouse_exited.connect(_unhover_fact.bind(fact))

func _input(ev):
	if ev is InputEventMouseButton:
		_handle_mouse_button(ev)
	elif ev is InputEventMouseMotion:
		_handle_mouse_motion(ev)

func _handle_mouse_button(ev):
	match ev.button_index:
		MOUSE_BUTTON_LEFT:
			if not ev.pressed: dragging = null; return;
			if connecting:
				# Click an invalid target to leave connection mode
				if hovering == connecting.a or not connecting.b:
					pass
				# Re-apply a connection to remove it
				elif connections.any(func (c): return Connection.eq(connecting, c)):
					remove_connection(connecting)
				# Click a valid target to create a connection
				elif connecting.b:
					add_connection(connecting)
				connecting = null
			elif hovering and ev.double_click:
				connecting = Connection.new(hovering, null)
			else: dragging = hovering
	queue_redraw()

func _handle_mouse_motion(ev):
	if dragging: 
		dragging.position += ev.relative / get_viewport().get_camera_2d().zoom
		queue_redraw()
	if connecting:
		queue_redraw()
