extends Panel

onready var name_field = $Fields/Name/LineEdit
onready var framerate_field = $Fields/FrameRate/HSlider
onready var song_field = $Fields/Song/OptionButton
onready var bpm_field = $Fields/Bpm/SpinBox

# Called when the node enters the scene tree for the first time.
func _ready():
	name_field.connect("text_entered", self, "set_name")
	framerate_field.connect("value_changed", self, "set_framerate")
	song_field.connect("button_up", self, "get_audio_list")
	song_field.connect("item_selected", self, "load_song")
	bpm_field.connect("value_changed", self, "set_bpm")

# Name Field
func set_name(text: String):
	Data.stage_name = text
	print(Data.stage_name)

# Framerate Field
func set_framerate(value: float):
	var strings = ["6","12","24"]
	Data.framerate = int(value)
	$Fields/FrameRate/Label.text = strings[value]

# Song Field
func get_audio_list():
	if Assets.audio.size() != song_field.get_item_count():
		song_field.clear()
		for file in Assets.audio:
			song_field.add_item(file)
		load_song(0)
	
func load_song(idx):
	Data.conductor.reset()
	Data.conductor.stream = Assets.audio[song_field.get_item_text(idx)]
	set_song_length()

func set_bpm(value: float):
	Data.bpm = value
	set_song_length()

# Calculate the length of the currently loaded song in beats
func set_song_length():
	if Data.conductor.stream:
		Data.song_length_beats = int(Data.conductor.stream.get_length() / ((60.0/Data.bpm) / 2))
