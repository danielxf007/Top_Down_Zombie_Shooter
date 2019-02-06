extends "res://player/body_movement/states/motion/motion.gd"

var radial_vector = Vector2()
var walk_force_x = 0.0
var walk_force_y = 0.0
var speed_x = 0.0
var speed_y = 0.0
var velocity = Vector2()
var animation setget set_animation, get_animation

func set_animation(animation_name):
	animation = animation_name

func get_animation():
	return animation

func handle_animation(ani_name):
	owner.AnimationPlayer.play(ani_name)

func handle_input(event):
	return .handle_input(event)

func update_movement_direction(angle):
	radial_vector.x = cos(angle)
	radial_vector.y = sin(angle)

func calculate_angle():
	var mouse_pos = get_mouse_direction()
	var player_pos = owner.global_position.normalized()
	return mouse_pos.angle_to(player_pos)

func type_of_movement():
	var type_of_movement = null
	var move_up = Input.is_action_pressed("up")
	var move_down = Input.is_action_pressed("down")
	if move_up or move_down:
		type_of_movement = Vector2(0, int(move_up) - int(move_down)) 
		return type_of_movement
	var strafe_right = Input.is_action_pressed("right")
	var strafe_left = Input.is_action_pressed("left")
	if strafe_right or strafe_left:
		type_of_movement = Vector2(int(strafe_right) - int(strafe_left), 0) 
		return type_of_movement
	return type_of_movement