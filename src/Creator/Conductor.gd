extends AudioStreamPlayer

var song_position = 0
var last_half_beat = 0

signal beat(current_beat)

func _process(_delta):
	if playing: 
		#Get song position & Account for Latency
		song_position = (
			get_playback_position() 
			+ AudioServer.get_time_since_last_mix()
			- AudioServer.get_output_latency()
		)

		var half_beat = int(song_position / ((60.0/126.0) * 0.5))
		
		if half_beat > last_half_beat:
			last_half_beat = half_beat
			Data.current_beat = half_beat
			emit_signal("beat", half_beat)
			print(Data.current_beat)

func update_song(path):
	reset()
	
	stream = load(path)
	play()

func reset():
	song_position = 0
	last_half_beat = 0
