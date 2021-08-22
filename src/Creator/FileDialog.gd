extends FileDialog

onready var animation_node = get_node('../Main/Preview/Animation')
onready var conductor = get_node('../Conductor')

enum {SONG, ANIMATION}
var update_index = -1

func _ready():
	if connect('file_selected', self, 'file_selected') == OK: pass
	if connect('update_animation', animation_node, 'update_animation') == OK: pass
	if connect('update_song', conductor, 'update_song') == OK: pass

var file_filters = [
	['*.ogg; OGG'], # Song
	['*.png; PNG', '*.jpg; JPEG'] # Animation
]

signal update_animation(path)
signal update_song(path)

# Opens the filedialog with type and index for getting global variables
func get_file(type):
	update_index = type
	filters = file_filters[type]
	popup()

# Emits signal when file selected
func file_selected(path: String):
	print(update_index)
	match update_index:
		SONG:
			emit_signal("update_song", path)
		ANIMATION:
			emit_signal("update_animation", path)
			
			
	print(path)