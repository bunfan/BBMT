extends HBoxContainer

onready var plus_sprites = $SpriteSheets/Bar/Plus
onready var sort_sprites = $SpriteSheets/Bar/Sort

onready var plus_audio = $Audio/Bar/Plus
onready var sort_audio = $Audio/Bar/Sort

const ui_sound = preload("res://assets/ui/bounbaves.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	plus_sprites.connect("button_up", self, 'open_asset', [['*.png; PNG']])
	plus_audio.connect("button_up", self, 'open_asset', [['*.ogg; OGG']])

# Get Sprite Sheet
func open_asset(type: Array):
	print("Opening file...")
	var file_dialog = FileDialog.new()
	# Set Transforms
	file_dialog.rect_size = Vector2(400,400)

	# Connect files selected
	file_dialog.connect('files_selected', self, '_on_files_selected', [type])

	# Set Mode
	file_dialog.mode = 1 # MODE_OPEN_FILES
	file_dialog.access = 2 # ACCESS_FILESYSTEM
	file_dialog.filters = type
	
	get_tree().current_scene.add_child(file_dialog)
	file_dialog.popup()

func _on_files_selected(paths: PoolStringArray, type):

	match type:
		['*.png; PNG']:
			for path in paths:
				var texture = Base.load_texture(path)
				Assets.images[Base.filename_from_path(path)] = texture
			populate_image_list()
		['*.ogg; OGG']:
			for path in paths:
				var audio = Base.load_audio(path)
				Assets.audio[Base.filename_from_path(path)] = audio
			populate_audio_list()

func populate_image_list():
	# Clear List
	for child in $SpriteSheets/Thumbs.get_children():
		child.queue_free()

	# Re-populate
	for sheet in Assets.images:

		# Vbox
		var vbox = VBoxContainer.new()
		vbox.set("custom_constants/separation", 10)
		$SpriteSheets/Thumbs.add_child(vbox)

		#Background Panel
		var bg_panel = Panel.new()
		bg_panel.size_flags_horizontal = 3 #SIZE_EXPAND_FILL
		bg_panel.rect_min_size = Vector2(96,84)

		# Style for Background Panel
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.05,0.05,0.05,1) 
		style.corner_radius_bottom_left = 10
		style.corner_radius_top_left = 10
		style.corner_radius_bottom_right = 10
		style.corner_radius_top_right = 10
		bg_panel.add_stylebox_override("panel", style)
		vbox.add_child(bg_panel)

		# Image inside of panel
		var thumbnail = TextureRect.new()
		thumbnail.expand = true
		thumbnail.stretch_mode = 6 #KEEP_ASPECT_CENTERED
		thumbnail.set_anchors_preset(15)
		thumbnail.margin_top = 10
		thumbnail.margin_bottom = -10
		thumbnail.texture = Assets.images[sheet]
		bg_panel.add_child(thumbnail)

		var label = Label.new()
		label.autowrap = true
		label.text = sheet
		label.align = 1
		label.valign = 1
		label.set_anchors_preset(15) #FULL_RECT

		var font = DynamicFont.new()
		font.font_data = load("res://assets/font/HelvetiPixel.ttf")
		font.size = 12
		label.set("custom_fonts/font", font)

		vbox.add_child(label)

func populate_audio_list():
	# Clear List
	for child in $Audio/Thumbs.get_children():
		child.queue_free()

	# Re-populate
	for sheet in Assets.audio:

		# Vbox
		var vbox = VBoxContainer.new()
		vbox.set("custom_constants/separation", 10)
		$Audio/Thumbs.add_child(vbox)

		#Background Panel
		var bg_panel = Panel.new()
		bg_panel.size_flags_horizontal = 3 #SIZE_EXPAND_FILL
		bg_panel.rect_min_size = Vector2(96,84)

		# Style for Background Panel
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.05,0.05,0.05,1) 
		style.corner_radius_bottom_left = 10
		style.corner_radius_top_left = 10
		style.corner_radius_bottom_right = 10
		style.corner_radius_top_right = 10
		bg_panel.add_stylebox_override("panel", style)
		vbox.add_child(bg_panel)

		# Image inside of panel
		var thumbnail = TextureRect.new()
		thumbnail.expand = true
		thumbnail.stretch_mode = 6 #KEEP_ASPECT_CENTERED
		thumbnail.set_anchors_preset(15)
		thumbnail.margin_top = 10
		thumbnail.margin_bottom = -10
		thumbnail.texture = ui_sound
		bg_panel.add_child(thumbnail)

		var label = Label.new()
		label.autowrap = true
		label.text = sheet
		label.align = 1
		label.valign = 1
		label.set_anchors_preset(15) #FULL_RECT

		var font = DynamicFont.new()
		font.font_data = load("res://assets/font/HelvetiPixel.ttf")
		font.size = 12
		label.set("custom_fonts/font", font)

		vbox.add_child(label)
