extends "res://player/body_movement/states/motion/motion.gd"

var radial_vector = Vector2()
var speed = 0.0
var velocity
var animation setget set_animation, get_animation

func enter():
	handle_animation(animation)

func exit():
	return

func accelerating():
	return Input.is_action_pressed("run")

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
