extends Control

onready var conductor = get_node('/root/Editor/Conductor')

onready var music = $Settings/Fields/Music
onready var bpm = $Settings/Fields/Bpm
onready var loop_speed = $Settings/Fields/LoopSpeed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Add asset object to array
func add_asset(section, idx):
	print("Opening %s" % section)

	# Get asset panel conatiner
	var asset_conatiner = section.get_node("Assets")
	
	# Get Asset
	Assets.open_asset(self, idx, asset_conatiner)


func add_music():
	Assets.open_music_asset(self, $Settings/Fields/Music/LineEdit)
	
func change_bpm(value: float):
	Data.bpm = value
	conductor.reset()

func change_loop_speed(value: float):
	Data.loop_speed = value
	get_node('/root/Editor/Tabs/Transitions/Preview/SpriteSheet/AnimationPlayer').playback_speed = 2 * Data.loop_speed
