extends Control

onready var mod_name = $NewModSplash/CenterContainer/Panel/ModName

func _ready():
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
	Run.init_mod_folders(mod_name.text)

# Debugging
func _input(event):
	if event.is_action_pressed("debug"):
		Base.open(Data.mod_path)
	
