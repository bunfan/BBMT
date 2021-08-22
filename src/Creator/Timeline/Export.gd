extends Button


var err
var export_array = []
var speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	err = connect("button_up", self, 'time_notes')

func time_notes():
	print('Calculating animation times')
	# Make a clean array
	export_array = []
	speed = 0
	# Get the distance to the next note to gauge timing
	for n in Data.written_notes.size():
		if n+1 < Data.written_notes.size():
			var time_til_next = Data.written_notes[n+1][0] - Data.written_notes[n][0]
			if time_til_next >=4:
				speed = 0
			elif time_til_next ==2:
				speed = 1
			elif time_til_next ==1:
				speed = 2
			else:
				speed = 0
		else:
			speed = 0
		# Append to array
		var note = Data.written_notes[n]
		export_array.append([note[0],note[1],speed])

	export_chart()


func export_chart():
	print('Exporting Chart')
	# Create File with array
	var c = ConfigFile.new()
	c.set_value('META', 'notes', export_array)
	c.save("res://notes.cfg")
	# Open File
	err = OS.shell_open(ProjectSettings.globalize_path("res://notes.cfg"))





