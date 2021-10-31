extends Control

onready var asset_selectors = $AssetSelectors.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():	

	# Connect item buttons
	# for i in asset_selectors.size():
	# 	asset_selectors[i].connect('item_selected', self, "change_preview", [i])

	# Connect item buttons
	var _e = $CreateTransition.connect('button_up', self, "create_transition")
	
	# Set preview speed
	$Preview/SpriteSheet/AnimationPlayer.playback_speed = 2 * Data.loop_speed


func populate_options():
	# Clear all option buttons
	for option in asset_selectors:
		option.clear()

	# For every asset array in the assets class
	for i in Assets.assets.size():
		# Check if it's empty
		if Assets.assets[i].size() < 1: return
		# Add item to corresponding option button
		for asset in Assets.assets[i]:
			asset_selectors[i].add_item(asset[0])

# Change animation preview
# func change_preview(idx, i):
# 	if i == 0:
# 		$Preview/SpriteSheet.texture = Assets.animations[idx][1]

func _on_beat(beat):
	if beat % 2 == 0:
		$Preview/SpriteSheet/AnimationPlayer.stop()
		$Preview/SpriteSheet/AnimationPlayer.play(Data.frame_rate_anim)


func create_transition():


	print(Assets.animations[$AssetSelectors/AnimationOption.selected][1])
			
	# Transitions.library.append(key_frame)

	print('Creating Transition')
	print(Transitions.library)
