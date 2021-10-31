extends Node

# Asset Arrays
var images: Dictionary
var audio: Dictionary

func clear_assets():
	images.clear()
	audio.clear()



# Load music into assets
# func _on_music_selected(path, file_dialog, field):
# 	var ogg_file = File.new() # Instance new File Class
# 	ogg_file.open(path, File.READ) # Read File
# 	var bytes = ogg_file.get_buffer(ogg_file.get_len()) # Get data of OGG file in Bytes

# 	var ogg_stream = AudioStreamOGGVorbis.new() # Instance new Audio Stream
# 	ogg_stream.data = bytes # Copy Bytes from file to stream data
# 	ogg_file.close() # Close File
	
# 	# Write to conductor and reset
# 	var conductor = get_node('/root/Editor/Conductor')
# 	conductor.stream = ogg_stream
# 	conductor.reset()
	
# 	# Remove dialog
# 	file_dialog.queue_free() 

# 	field.text = filename_from_path(path)



	




