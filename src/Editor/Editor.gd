extends Control

# Mod Creation Work flow
#
# - Import all assets into libraries (Animations, Effects, Sounds, Music)
# - Create Transition objects using imported assets
# - Use timeline to set notes
# - Export

# TODO : Create transition management system similar to Beat Banger
# TODO : User transition management system to load transition dynamically with song

# DONE : Create tabs for switching panels
# DONE : Create Dropdown selection for transition assets


# Called when the node enters the scene tree for the first time.
func _ready():

	# Fade in
	Base.fade('from', 0.5)

	# Get all tab buttons
	for i in $Global/TabButtons.get_children().size():
		var tab = $Global/TabButtons.get_child(i)
		tab.connect('button_up', self , "tab_changed", [i])

	# Connect Global/Toolbar
	for i in $Global/Toolbar/Buttons.get_children().size():
		var tab = $Global/Toolbar/Buttons.get_child(i)
		tab.connect('button_up', self , "on_playback_button", [i])
	
	# Connect volume slider and set volume
	var _err = $Global/Toolbar/Volume.connect('value_changed', self , "change_volume")
	$Conductor.volume_db =  $Global/Toolbar/Volume.value
	print($Global/Toolbar/Volume.value)




func tab_changed(tab_index):

	# Get all tab windows
	for i in $Tabs.get_children().size():
		$Tabs.get_child(i).visible = false
	$Tabs.get_child(tab_index).visible = true


# When Play or stop is pressed
func on_playback_button(i):
	match i:
		0:
			$Conductor.reset()
			$Conductor.play()
			$Tabs/Transitions/Preview/SpriteSheet/AnimationPlayer.play(Data.frame_rate_anim)
		1:
			$Conductor.stop()

# When volume slider changes
func change_volume(value: float):
	if value <= -40:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
		$Conductor.volume_db = value
