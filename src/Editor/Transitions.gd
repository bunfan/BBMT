extends Control

onready var asset_selectors = $AssetSelectors.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():

	

	for i in asset_selectors.size():
		asset_selectors[i].connect('item_selected', self, "change_preview", [i])
	
	$Preview/SpriteSheet/AnimationPlayer.playback_speed = 2
	


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
func change_preview(idx, i):
	if i == 0:
		$Preview/SpriteSheet.texture = Assets.animations[idx][1]

func _on_beat(beat):
	if beat % 2 == 0:
		print('Playing')
		$Preview/SpriteSheet/AnimationPlayer.stop()
		$Preview/SpriteSheet/AnimationPlayer.play()