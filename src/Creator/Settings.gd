extends VBoxContainer

onready var animation_player = get_node('/root/Creator/Main/Preview/Animation/AnimationPlayer')

enum {BPM,LOOP}
onready var settings = $Bpm/SpinBox
onready var loop_speed = $LoopSpeed/SpinBox

func _ready():
	if settings.connect('value_changed', self, 'set_settings', [BPM]) == OK: pass
	if loop_speed.connect('value_changed', self, 'set_settings', [LOOP]) == OK: pass


func set_settings(value, index):
	match index:
		BPM:
			Data.bpm = value
		LOOP:
			Data.loop_speed = value
			animation_player.playback_speed = value * 2
	
