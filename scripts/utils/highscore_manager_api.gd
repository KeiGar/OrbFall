extends Node

const BASE_URL = "https://api.keigartner.com/orbfall/highscore"
const CLIENT_KEY = "ORBFALL-HIGHSCORE-API"

var Highscores_Received: Array[HighscoreManager.HighscoreData] = []

signal leaderboard_received(data)
signal score_upload_success

func _ready() -> void:
	fetch_highscore() # fetch highscore on game boot

func upload_highscore(player_name: String, score: int) -> void:
	var http_request = HTTPRequest.new()
	http_request.request_completed.connect(_on_request_completed)
	add_child(http_request)
	print("Uploading score for ", player_name)
	var score_str : String = str(score)
	var hmac_str = (player_name + score_str + CLIENT_KEY).sha256_text()
	var data = { 
		"player_id": PlayerVariables.player_uid,
		"player_name": player_name,
		"score": score
	}
	var body = JSON.stringify(data)
	var headers = [
		"Content-Type: application/json",
		"x-orbfall-hmac: " + hmac_str
		]
	var response = http_request.request(BASE_URL, headers, HTTPClient.METHOD_POST, body)
	if response != OK:
		push_error("An error ocurred while attempting to save the Highscore to the database.")
		
func fetch_highscore() -> void:
	var http_request = HTTPRequest.new()
	http_request.request_completed.connect(_on_request_completed)
	add_child(http_request)
	print("Fetching top scores...")
	var headers = ["Content-Type: application/json"]
	var error = http_request.request(BASE_URL, headers, HTTPClient.METHOD_GET)
	if error != OK:
		push_error("An error occurred while attempting to fetch the score from the database.")
		
# --- Unified Response Handler ---
func _on_request_completed(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray):
	if response_code != 200:
		print("API Error! Code: ", response_code)
		print("Response: ", body.get_string_from_utf8())
		return

	var json_data = JSON.parse_string(body.get_string_from_utf8())
	
	if json_data == null:
		print("Failed to parse JSON response.")
		return

	# Logic to distinguish between the POST and GET responses
	if json_data.has("leaderboard"):
		# This is a GET response
		emit_signal("leaderboard_received", json_data["leaderboard"])
		_on_leaderboard_received(json_data["leaderboard"])
		_print_scores(json_data["leaderboard"])
		
	elif json_data.has("message"):
		# This is a POST response (from our Lambda 'save_highscore' return)
		print("Server says: ", json_data["message"])
		fetch_highscore()
		# emit_signal("score_upload_success")

func _print_scores(scores: Array):
	print("--- CURRENT LEADERBOARD ---")
	for i in range(scores.size()):
		var entry = scores[i]
		print("%d. %s: %d" % [i + 1, entry["name"], entry["score"]])
		
func _on_leaderboard_received(data) -> void:
	Highscores_Received.clear()
	for entry in data:
		Highscores_Received.append(HighscoreManager.HighscoreData.new(entry.name, entry.score))
