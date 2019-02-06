extends "res://player/body_movement/states/motion/on_ground/on_ground.gd"

func enter():
	velocity = Vector2()
	.enter()

func exit():
	return

func handle_input(event):
	return .handle_input(event)

func update(delta):
	if type_of_movement() == null:
		var angle = calculate_angle()
		update_look_direction(update_movement_direction(angle))
		owner.move_and_slide(velocity)
	else:
		emit_signal("finished", "Move")