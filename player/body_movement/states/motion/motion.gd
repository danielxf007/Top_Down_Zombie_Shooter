extends "res://player/body_movement/states/state.gd"

func get_mouse_direction():
	var mouse_pos = get_viewport().get_mouse_position().normalized()
	return mouse_pos

func update_look_direction(direction):
	if direction and owner.look_direction != direction:
		owner.set_look_direction(direction)

func handle_input(event):
	if event.is_action_pressed("shot"):
		emit_signal("finished", "Shot")
	if event.is_action_pressed("mele_attack"):
		emit_signal("finished", "Mele_attack")