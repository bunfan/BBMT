extends VBoxContainer

onready var conductor = get_node('/root/Creator/Conductor')

var x

# Called when the node enters the scene tree for the first time.
func _ready():
	x = $Play.connect('button_up', self, 'play')
	x = $Stop.connect('button_up', self, 'stop')

func play():
	conductor.play()

func stop():
	conductor.stop()
	conductor.reset()