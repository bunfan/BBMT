extends Control

var export_array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var _e = $Notes.connect("button_up", self, "export_notes")

func export_notes():

	export_array.clear()
	export_array = Data.written_notes.duplicate(true)
	print(export_array)

	# Do nothing if no notes are written
	if export_array.size() <= 0: return

	# For every note in the written notes array
	for i in export_array.size():

		# Makes sure not to go past the last note in the array
		if i+1 < export_array.size():

			# Appends the animation speed based on the time until the next note
			var beats_til_next_note = export_array[i+1][0] - export_array[i][0]
			export_array[i].append(calculate_anim_speed(beats_til_next_note))

	# Append speed multiplier "0" to the last note 
	export_array[export_array.size()-1].append(0)
	
	write_notes_to_file()

# The the speed multiplier used in beat banger
func calculate_anim_speed(beats_til_next_note):
		if beats_til_next_note >= 4:
			return 0
		elif beats_til_next_note == 2:
			return 1
		elif beats_til_next_note == 1:
			return 2
		else:
			return 0

func write_notes_to_file():
	print("Exporting %s notes to notes.cfg" % export_array.size())

	var cfg = ConfigFile.new()
	cfg.set_value("main","data", {"chart":export_array})
	cfg.save("user://notes.cfg")
	if OS.shell_open(ProjectSettings.globalize_path("user://")) == OK: pass
