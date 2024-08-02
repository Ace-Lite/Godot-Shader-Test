extends Node3D

# Called when the node enters the scene tree for the first time.
var camera
var body 

func _ready():
	camera = get_node("Camera_Wise")
	body = get_node("CharacterBody3D")
	pass # Replace with function body.

var momentum = Vector3(0, 0, 0)

const FIXED_SIZE = 1000
const NULLIZIED_VECT = Vector3(0, 0, 0)
const FIXED_VELOCITY = 0.0225
const GRAVITY = -0.98/FIXED_SIZE


func get_current_movement_angle():
	var move = false
	var anglet = Vector3(0, 0, 0)
	
	if Input.is_action_pressed("ui_right"):
		anglet += Vector3(-1, 0, 0)
		move = true
	if Input.is_action_pressed("ui_left"):
		anglet += Vector3(1, 0, 0)
		move = true
	if Input.is_action_pressed("ui_up"):
		anglet += Vector3(0, 0, 1)
		move = true
	if Input.is_action_pressed("ui_down"):
		anglet += Vector3(0, 0, -1)
		move = true

	# print(move)
	return [move, anglet.normalized()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var angle_move = get_current_movement_angle()
	var fixed_move = Vector3(0, 0, 0)
	
	if angle_move[0]:
		fixed_move = FIXED_VELOCITY * angle_move[1]

	momentum += fixed_move
	# print(momentum)

	if camera:
		camera.position = position - Vector3(0, -1.656, 1.702)

	body.velocity = momentum/64 + Vector3(0, -GRAVITY, 0)
	body.move_and_collide(body.velocity * delta)
	body.global_transform.basis.looking_at(position - camera.position)
	position = body.position
	
	momentum = momentum.lerp(NULLIZIED_VECT, delta/2)
