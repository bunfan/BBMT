extends Panel


onready var note_container = $Scroll/Notes

var notes_in_timeline = []


# Called when the node enters the scene tree for the first time.
func _ready():
	Data.timeline = self
	print(Data.timeline)


func draw_notes():

	for note in note_container.get_children():
		note.queue_free()

	print(Data.song_length_beats)

	for i in Data.song_length_beats:

		# Background
		var panel = Panel.new()
		panel.rect_min_size = Vector2(50,50)

		# Style
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.3,0.3,0.3,1) 
		panel.add_stylebox_override("panel", style)
		note_container.add_child(panel)

		var label = Scene.create_label(str(i), 28)
		panel.add_child(label)

		# Add each note "panel" to an array to be modified (Color, Brightness, etc.)
		notes_in_timeline.append()





	
