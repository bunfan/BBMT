extends Control

onready var mod_name = $NewModSplash/CenterContainer/Panel/ModName

func _ready():
	Base.fade('from', 0.5)
	Base.log('Tool Started')
	Run.setup()

# Button Handling
func _on_NewMod_button_up():
	$NewModSplash.visible = true
	$Sound/Click.play()

func _on_GoBack_button_up():
	$NewModSplash.visible = false
	$Sound/Click.play()

func _on_CreateMod_button_up():
	# Run.init_mod_folders(mod_name.text)
	Base.fade('to', 0.5)
	Base.slow_load('res://src/Editor/Editor.tscn', 0.5)

# Debugging
func _input(event):
	if event.is_action_pressed("debug"):
		Base.open(Data.mod_path)
	
