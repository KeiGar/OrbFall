extends BoxContainer
@onready var lbl_time: Label = $LBLTime

var time_start:= Time.get_ticks_msec()
var time_curr:= Time.get_ticks_msec() - time_start
var time_elapsed:= 0.0

func _process(delta: float) -> void:
	time_curr = Time.get_ticks_msec() - time_start
	time_elapsed += delta
	lbl_time.text = str(time_elapsed).pad_decimals(2)
	# lbl_time.text = _converTimeToStringFormatFromMsec(time_curr)

func _converTimeToStringFormatFromMsec(timeCurr: int) -> String: 
	var seconds:= (int)(timeCurr / 1000.0)
	var minutes:= (int)(seconds / 60.0)
	var secondsRemainder:= (int)(seconds % 60)
	var timeDisplay: String = "%02d:%02d" % [minutes, secondsRemainder]
	return timeDisplay
	
