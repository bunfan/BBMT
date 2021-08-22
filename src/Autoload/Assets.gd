extends Node

const image_asset_visual = preload('res://src/Editor/Importer/Prefabs/ImageAsset.tscn')
const audio_asset_visual = preload('res://src/Editor/Importer/Prefabs/AudioAsset.tscn')

onready var conductor = get_node('/root/Editor/Conductor')

# Asset Arrays
var animations: Array
var effects: Array
var sounds: Array

var assets = [
		animations,
		effects,
		sounds,
	]

enum {ANIMATION,EFFECTS,AUDIO}

func clear_assets():
	animations.clear()

# Opens a file dialog and gets the path of the file
func open_asset(node, type, visual_slot):
	# Create File Dialog
	var file_dialog = FileDialog.new()
	
	# Set Transforms
	file_dialog.rect_size = Vector2(400,400)

	# Set Mode
	file_dialog.mode = 1 # MODE_OPEN_FILES
	file_dialog.access = 2 # ACCESS_FILESYSTEM
	
	# Check type and format dialog
	match type:
		ANIMATION:
			file_dialog.filters = ['*.png; PNG', '*.jpg; JPG']
		EFFECTS:
			file_dialog.filters = ['*.png; PNG', '*.jpg; JPG']
		AUDIO:
			file_dialog.filters = ['*.ogg; OGG']

	# Add to scene
	node.add_child(file_dialog)
	file_dialog.connect('files_selected', self, '_on_file_selected', [file_dialog, type, visual_slot])
	file_dialog.current_path = 'E:/Mega/Projects/BunFan/Games/Beat_Banger_Game/Beat_Banger/data/judy/anims'
	file_dialog.popup()


# Run on file selected
func _on_file_selected(paths, file_dialog, type, visual_slot):
	for path in paths:
		match type:
			ANIMATION:
				load_texture(path, type, visual_slot)
			EFFECTS:
				load_texture(path, type, visual_slot)
			AUDIO:
				load_audio(path, type, visual_slot)
				
	# Remove File Object
	file_dialog.queue_free() 

	print(JSON.print(assets, '\t'))

# Opens the music file
func open_music_asset(node):
	# Create File Dialog
	var file_dialog = FileDialog.new()
	
	# Set Transforms
	file_dialog.rect_size = Vector2(400,400)

	# Set Mode
	file_dialog.mode = 0 # MODE_OPEN_FILE
	file_dialog.access = 2 # ACCESS_FILESYSTEM
	file_dialog.filters = ['*.ogg; OGG']

	# Add to scene
	node.add_child(file_dialog)
	file_dialog.connect('file_selected', self, '_on_music_selected', [file_dialog])
	file_dialog.current_path = 'E:/Mega/Projects/BunFan/Games/Beat_Banger_Game/Beat_Banger/data/judy/anims'
	file_dialog.popup()

# Load music into assets
func _on_music_selected(path, file_dialog):
	var ogg_file = File.new() # Instance new File Class
	ogg_file.open(path, File.READ) # Read File
	var bytes = ogg_file.get_buffer(ogg_file.get_len()) # Get data of OGG file in Bytes

	var ogg_stream = AudioStreamOGGVorbis.new() # Instance new Audio Stream
	ogg_stream.data = bytes # Copy Bytes from file to stream data
	ogg_file.close() # Close File
	
	# Write to conductor and reset
	conductor.stream = ogg_stream
	conductor.reset()
	
	# Remove dialog
	file_dialog.queue_free() 



	
# Load image asset
func load_texture(path, type, visual_slot):

	# Load image and convert to Godot readable texture
	var loaded_image = Image.new()
	loaded_image.load(path)

	var created_texture = ImageTexture.new()
	created_texture.create_from_image(loaded_image)

	# Cut file path string to individual files name
	var filename = path.rsplit("/", true,1)[1]

	# Push To Array -> [ "Filename", ImageTexture ]
	assets[type].append([filename, created_texture])

	# Create the visual asset object in list
	var v = image_asset_visual.instance()
	visual_slot.add_child(v)
	v.get_node("Label").text = filename
	v.get_node("Container/Image").texture = created_texture


# Load audio asset
func load_audio(path, type, visual_slot):
	var ogg_file = File.new() # Instance new File Class
	ogg_file.open(path, File.READ) # Read File
	var bytes = ogg_file.get_buffer(ogg_file.get_len()) # Get data of OGG file in Bytes

	var ogg_stream = AudioStreamOGGVorbis.new() # Instance new Audio Stream
	ogg_stream.data = bytes # Copy Bytes from file to stream data
	ogg_file.close() # Close File

	# Cut file path string to individual files name
	var filename = path.rsplit("/", true,1)[1]

	# Push To Array -> [ "Filename", AudioStream ]
	assets[type].append([filename, ogg_stream])

	# Create the visual asset object in list
	var v = audio_asset_visual.instance()
	visual_slot.add_child(v)
	v.get_node("Label").text = filename
