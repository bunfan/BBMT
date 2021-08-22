extends Control

onready var music = $Settings/Fields/Music
onready var bpm = $Settings/Fields/Bpm

# Called when the node enters the scene tree for the first time.
func _ready():

	# Connect the add asset button for each asset section
	for idx in $Sections.get_child_count():
		var section = $Sections.get_child(idx)
		section.get_node("AddButton").connect('button_up', self, 'add_asset', [section, idx])

	# Connect load music button
	music.get_node('Button').connect('button_up', self, 'add_music')

	# Connect BPM
	bpm.get_node('Input').connect('value_changed', self, 'change_bpm')




# Add asset object to array
func add_asset(section, idx):
	print("Opening %s" % section)

	# Get asset panel conatiner
	var asset_conatiner = section.get_node("Assets")
	
	# Get Asset
	Assets.open_asset(self, idx, asset_conatiner)


func add_music():
	Assets.open_music_asset(self)
	
func change_bpm(value: float):
	Data.bpm = value
	Assets.conductor.reset()


