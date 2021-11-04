extends Label

func _ready():
	if $Progress.connect("value_changed", self, "get_time") == OK: pass
	if $Progress.connect("gui_input", self, "touched") == OK: pass

func _process(_delta):
	# Update beat indicator UI if stream located
	if Data.conductor.stream:
		text = "Beat : %s / %s" % [Data.current_beat, Data.song_length_beats]

		$Progress.max_value = Data.song_length_beats
		$Progress.value = Data.current_beat

var seeker_dest 
func get_time(value: float):
	seeker_dest = value

func touched(event):
	if event is InputEventMouseButton: return true
		# var new_song_pos = ( (60.0/Data.bpm) / 2 ) * seeker_dest
		# Data.conductor.seek(50)
		# print(event)


	

	
