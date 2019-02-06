extends "res://player/body_movement/states/motion/on_ground/on_ground.gd"

const WALK_FORCE = 500.0
const MAX_WALK_SPEED = 150.0
const MIN_WALK_SPEED = 20.0
var type_of_movement
var last_type_of_movement
var current_type_of_movement

func enter():
	speed = 0.0
	velocity = Vector2()

func update(delta):
	var type_of_movement =  type_of_movement()
	var angle = calculate_angle()
	update_look_direction(update_movement_direction(angle))
	update_movement_direction(angle)
	move(type_of_movement, delta)

func update_velocity_direction(type_movement):
	match(type_movement):
		"move_normal":
			velocity = radial_vector * type_of_movement.y
			last_type_of_movement = current_type_of_movement
			current_type_of_movement = type_movement
			if current_type_of_movement != last_type_of_movement:
				if type_of_movement.y > 0:
					handle_animation("advance")
				else:
					handle_animation("back")
		"strafe":
			velocity = radial_vector * type_of_movement.x
			velocity = radial_vector * type_of_movement.y
			last_type_of_movement = current_type_of_movement
			current_type_of_movement = type_movement
			if current_type_of_movement != last_type_of_movement:
				if type_of_movement.x > 0:
					handle_animation("strafe_right")
				else:
					handle_animation("strafe_left")
		null:
			emit_signal("finished", "Idle")

func move(type_of_movement, delta):
	update_velocity_direction(type_of_movement)
	calculate_speed(delta)
	velocity = velocity * speed
	owner.move_and_slide(velocity)

func calculate_speed(delta):
	if accelerating():
		speed += WALK_FORCE * delta
		if speed > MAX_WALK_SPEED:
			speed = MAX_WALK_SPEED
	else:
		speed = MIN_WALK_SPEED

func handle_input(event):
	return .handle_input(event)

func type_of_movement():
	var move_up = Input.is_action_pressed("up")
	var move_down = Input.is_action_pressed("down")
	if move_up or move_down:
		type_of_movement = Vector2(0, int(move_up) - int(move_down)) 
		return "move_normal"
	var strafe_right = Input.is_action_pressed("right")
	var strafe_left = Input.is_action_pressed("left")
	if strafe_right or strafe_left:
		type_of_movement = Vector2(int(strafe_right) - int(strafe_left), 0) 
		return "strafe"
	return null