extends Node


func log(string: String):
	var time = "%02d:%02d:%02d" % [OS.get_time().hour,OS.get_time().minute,OS.get_time().second]
	print("(%s) %s" % [time, string])

func open(path):
	if OS.shell_open(path) == OK:
		pass

func load_scene(path):
	if get_tree().change_scene(path) == OK:
		pass

func fade(type, duration):

	# Create full screen canvas
	var canvas = ColorRect.new()
	canvas.color = Color(0,0,0,1)
	canvas.set_anchors_preset(15)
	canvas.mouse_filter = 2 #MOUSE_FILTER_IGNORE
	get_tree().get_current_scene().add_child(canvas)

	# Define alpha fade
	var a1 = 0 if type == 'to' else 1
	var a2 = 0 if type == 'from' else 1

	# Create Tween Object
	var tween = Tween.new()
	add_child(tween)
	tween.connect('tween_all_completed', self, '_on_tween_completed', [tween, canvas])

	# Run Tween
	tween.interpolate_property(canvas, 'color', Color(0,0,0,a1), Color(0,0,0,a2), duration, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()

func _on_tween_completed(tween, canvas):
	tween.queue_free()
	if is_instance_valid(canvas):
		canvas.queue_free()

func slow_load(scene, duration):

	# Disable input during fade
	get_tree().get_root().set_disable_input(true)
	yield(get_tree().create_timer(duration), "timeout" )

	# Re-enable input and change the scene
	get_tree().get_root().set_disable_input(false)
	return get_tree().change_scene(scene)

# Load image asset
func load_texture(path):
	# Load image and convert to Godot readable texture
	var loaded_image = Image.new()
	loaded_image.load(path)

	var texture = ImageTexture.new()
	texture.create_from_image(loaded_image)

	return texture

	# Push To Array -> [ "Filename", ImageTexture ]
	# assets[type].append([filename_from_path(path), created_texture])


# Loads OGG file
func load_audio(path):
	var ogg_file = File.new() # Instance new File Class
	ogg_file.open(path, File.READ) # Read File
	var bytes = ogg_file.get_buffer(ogg_file.get_len()) # Get data of OGG file in Bytes

	var ogg_stream = AudioStreamOGGVorbis.new() # Instance new Audio Stream
	ogg_stream.data = bytes # Copy Bytes from file to stream data
	ogg_file.close() # Close File

	return ogg_stream

	# Push To-> [ "Filename", AudioStream ]
	# return {filename_from_path(path): }

# Cut path to file name
func filename_from_path(path: String):
	return path.rsplit("/", true,1)[1]

func is_mouse_clicked(event: InputEvent, mouse_button_index: int):
	if event is InputEventMouseButton:
		if event.button_index == mouse_button_index:
			if event.pressed == true:
				return true
			else:
				return false
		else:
			return false
	else:
		return false
		
