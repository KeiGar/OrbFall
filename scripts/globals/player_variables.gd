extends Node
var player_score:int = 0
var player_name:String = ""
var player_uid := GameUtils.generate_uuid()

func _ready() -> void:
	print(player_uid)
