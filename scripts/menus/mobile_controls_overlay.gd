extends Control

var event_action := InputEventAction.new()

func _on_btn_button_up(action_name: String) -> void:
	event_action.action = action_name
	event_action.pressed = false
	Input.parse_input_event(event_action)

func _on_btn_button_down(action_name: String) -> void:
	event_action.action = action_name
	event_action.pressed = true
	Input.parse_input_event(event_action)
