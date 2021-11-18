extends Panel

# TODO : Note Coloring based on written notes array


onready var note_container = $Scroll/Notes

var physical_notes = []

var note_types = {
	90:0,
	88:1,
	67:2,
	86:3
}


# Called when the node enters the scene tree for the first time.
func _ready():
	Data.timeline = self
	print(Data.timeline)


func draw_notes():

	# Clears all note panels from the HBox container
	for note in note_container.get_children():
		note.queue_free()

	# Clears all note references from the "physical_notes" array
	physical_notes.clear()

	for i in Data.song_length_beats + 1:

		# Background
		var panel = Panel.new()
		panel.rect_min_size = Vector2(50,50)
		panel.self_modulate = Color(0.2,0.2,0.2,1)
		panel.set_focus_mode(2)

		# Style
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0,0,0,0) 
		style.border_width_bottom = 5
		style.border_width_top = 5
		style.border_width_left = 5
		style.border_width_right = 5
		style.corner_radius_bottom_left = 10
		style.corner_radius_bottom_right = 10
		style.corner_radius_top_left = 10
		style.corner_radius_top_right = 10
		style.border_color = Color(1,1,1,1) 
		panel.add_stylebox_override("panel", style)
		note_container.add_child(panel)

		var label = Scene.create_label(str(i), 28)
		panel.add_child(label)
		panel.connect("gui_input", self, 'note_clicked', [i])

		# Add each note "panel" to an array to be modified (Color, Brightness, etc.)
		physical_notes.append(panel)


func _input(event):
	if !event is InputEventKey: return

	if event.pressed:
		if note_types.has(event.physical_scancode):
			record_note(event.physical_scancode) 
			update_note_visuals()
			

func record_note(scancode):

	for note in Data.written_notes:
		if note[0] == Data.current_beat:
			return print("Beat already recorded")

	Data.written_notes.append([Data.current_beat, note_types[scancode]])
	print(Data.written_notes)

func note_clicked(event, idx):
	if Base.is_mouse_clicked(event, 2): # BUTTON_RIGHT

		# Remove Note
		for i in Data.written_notes.size():
			if Data.written_notes[i][0] == idx:
				Data.written_notes.erase(Data.written_notes[i])
				print("Removed Note %s : %s" % [idx, Data.written_notes[i]])
				update_note_visuals()
				return 

func update_note_visuals():

	# Do not run function if there are no physical note nodes in the timeline
	if physical_notes.size() <= 0: return

	print(physical_notes.size())

	# Set all notes to default color
	for i in physical_notes.size():

		physical_notes[i].self_modulate = Color(0.2,0.2,0.2,1)
		physical_notes[i].modulate = Color(1,1,1,1)
		
		for note in Data.written_notes:
			# If the current beat has a note assigned to it
			if note[0] == i:
				
				var colors = [
					Color(26,161,199,255)/255,
					Color(237,121,12,255)/255,
					Color(199,43,22,255)/255,
					Color(170,43,100,255)/255
				]
				
				physical_notes[i].modulate = colors[note[1]]

				
		


	# Highlight the note that sit at the index of the "current_beat"
	physical_notes[Data.current_beat].self_modulate = Color(1,1,1,1)
	physical_notes[Data.current_beat].grab_focus()










	
