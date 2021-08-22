extends AudioStreamPlayer

var song_position = 0
var beat = 0
var last_beat = 0

onready var transitions = get_node('/root/Editor/Tabs/Transitions')

func _ready():
	var _err = connect("beat", transitions, "_on_beat")

signal beat(current_beat)

func _process(_delta):
		
	if playing: 
		#Get song position & Account for Latency
		song_position = (
			get_playback_position() 
			+ AudioServer.get_time_since_last_mix()
			- AudioServer.get_output_latency()
		)

		# Get beat on every frame
		beat = int(song_position / ((60.0/Data.bpm) * 0.5))
		
		# Only send signal when the beat changes
		if beat > last_beat:
			last_beat = beat
			Data.current_beat = beat
			emit_signal("beat", beat)
			print(Data.current_beat)
	
func reset():
	song_position = 0
	last_beat = 0


