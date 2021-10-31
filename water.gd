extends Node2D
#tool
onready var static_1 = $Static_1
onready var point_1 = $Point_1
onready var border_line = $BorderLine
export (Texture) var water_texture
export (int) var whidth = 5
export (int) var offset_x = 3
var last_point: Object

# Called when the node enters the scene tree for the first time.
func _ready():
	var mat = PhysicsMaterial.new()
	mat.absorbent = true
	mat.bounce = 0
	mat.friction = 1.0
	mat.rough = true
	border_line.texture = water_texture
	border_line.width = border_line.texture.get_height()
	_create_points()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	_draw_water_line()


func _create_points():
	var new_obj
	var new_pin
	var old_obj = point_1
	old_obj.position.x = offset_x
	for i in whidth:
		new_obj = old_obj.duplicate()
		new_pin = PinJoint2D.new() 
		new_pin.scale = Vector2(0.3,0.3)
		new_obj.position.x = old_obj.position.x + offset_x
		new_pin.position = old_obj.position
		add_child(new_pin)
		add_child(new_obj)
		new_pin.node_a = old_obj.get_path()
		new_pin.node_b = new_obj.get_path()
		old_obj = new_obj
	new_obj = static_1.duplicate()
	new_pin = PinJoint2D.new()
	new_pin.scale = Vector2(0.3,0.3)
	new_obj.position.x = old_obj.position.x + offset_x
	new_pin.position = old_obj.position
	add_child(new_pin)
	add_child(new_obj)
	new_pin.node_a = old_obj.get_path()
	new_pin.node_b = new_obj.get_path()
	last_point = new_obj


func _draw_water_line():
	var line_points:PoolVector2Array
	for child in get_children():
		if (child is RigidBody2D) or (child is StaticBody2D):
			line_points.append(child.position + Vector2(0,border_line.width/2))
	border_line.points = line_points  


