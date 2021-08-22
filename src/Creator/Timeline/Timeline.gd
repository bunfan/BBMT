extends Control

onready var conductor = get_node('/root/Creator/Conductor')

var buttons = []

var page = 0

var existing_beats = []

var node_prefab = preload('res://src/TimelineNode/Node.tscn')

# Define Note Colors
var note_colors = [
	Color(0.1,0.55,0.78,1),
	Color(0.92,0.47,0.04,1),
	Color(0.78,0.16,0.08,1),
	Color(0.66,0.168,0.39,1),

]


func draw_nodes():

	# Add keyframe prefab
	for i in (Data.song_length + 1):
		var new_node = node_prefab.instance()
		$Cont/Line.add_child(new_node)

	# Append each timeline keyframe button to array, color, and connect
	for i in $Cont/Line.get_children().size():
		var node = $Cont/Line.get_child(i)
		buttons.append(node)
		node.connect('gui_input', self, 'node_pressed', [node])
	

	Data.selected_node = buttons[Data.selected_beat]
	color_notes()
	highlight_selected_keyframe()


func _on_beat(_beat):
	Data.selected_beat = Data.current_beat
	Data.selected_node = buttons[Data.selected_beat]
	highlight_selected_keyframe()

func node_pressed(event, node):

	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				# Go to keyframe position
				Data.selected_beat = buttons.find(node) + (page * 16)
				Data.selected_node = buttons[Data.selected_beat]
			BUTTON_RIGHT:
				# Go to keyframe position
				Data.selected_beat = buttons.find(node) + (page * 16)
				Data.selected_node = buttons[Data.selected_beat]
				print("Deleting note %s of type" % Data.selected_beat)
				remove_note()

	# Change labels
	$Label.text = 'Selected Beat : %s' % (Data.selected_beat + 1)
	$Label3.text = 'Selected Node : %s' % Data.selected_node
	$Label2.text = 'Page : %s' % (page + 1)
	highlight_selected_keyframe()

func color_notes():
	# Gray Colors
	for i in buttons.size():
		if i % 2 == 0:
			buttons[i].modulate = Color(0.6,0.6,0.6,1)
		else:
			buttons[i].modulate = Color(0.8,0.8,0.8,1)
	
	# Get keyframe color if written
	for i in buttons.size():
		if Data.written_notes.empty(): continue
		if Data.written_notes[i].empty(): continue
		buttons[i].modulate = note_colors[i]

	

func highlight_selected_keyframe():
	for node in buttons:
		node.self_modulate = Color(0.5,0.5,0.5,1)
	buttons[Data.selected_beat].self_modulate = Color(1,1,1,1)

func _input(event):

	if event.is_action_pressed('Z'):
		write_note(0)
	if event.is_action_pressed('X'):
		write_note(1)
	if event.is_action_pressed('C'):
		write_note(2)
	if event.is_action_pressed('V'):
		write_note(3)
	if event.is_action_pressed('S'):
		if conductor.playing == true: return
		Data.selected_beat += 1
		Data.selected_node = buttons[Data.selected_beat]
		highlight_selected_keyframe()

func write_note(type):
	
	# Check if no buttons are on the timeline
	if buttons.size() < 1: return 

	# Make sure the selected beat doesn't exist 
	if existing_beats.has(Data.selected_beat):
		# Check each note to see if it exists
		for i in Data.written_notes.size():
			if Data.written_notes[i][0] == Data.selected_beat:
				# Replace Note and return
				Data.written_notes[i] = [Data.selected_beat,type,0]
				buttons[Data.selected_beat].modulate = note_colors[type]
				Data.selected_beat += 1
				Data.selected_node = buttons[Data.selected_beat]
				highlight_selected_keyframe()
				return

	# Write note array
	Data.written_notes.append([Data.selected_beat,type])
	existing_beats.append(Data.selected_beat)

	# Move the beat cursor foward one time
	if conductor.playing == true: return
	Data.selected_beat += 1
	Data.selected_node = buttons[Data.selected_beat]

	# Refresh all node visuals
	color_notes()
	highlight_selected_keyframe()

	print(existing_beats)	

	
func remove_note():
	# Check if beat exists
	if existing_beats.has(Data.selected_beat):
		# Check each note to see if it exists
		for i in Data.written_notes.size():
			if Data.written_notes[i][0] == Data.selected_beat:
				Data.written_notes.remove(i)
				break
	
	# Highlight selected keyframe
	color_notes()
	highlight_selected_keyframe()

	print(Data.written_notes)	
