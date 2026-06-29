extends BoxContainer
@onready var lbl_time: Label = $LBLTime

var time_elapsed:= 0.0

func _process(delta: float) -> void:
	time_elapsed += delta
	lbl_time.text = convert_time_to_string_format_from_sec(time_elapsed)

func convert_time_to_string_format_from_sec(timeCurr: float) -> String:
	var seconds:= (int)(timeCurr)
	var minutes:= (int)(seconds / 60.0)
	var secondsRemainder:= (int)(seconds % 60)
	var timeDisplay: String = "%02d:%02d" % [minutes, secondsRemainder]
	return timeDisplay
	
