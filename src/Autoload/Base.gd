extends Node


func log(string: String):
	var time = "%02d:%02d:%02d" % [OS.get_time().hour,OS.get_time().minute,OS.get_time().second]
	print("(%s) %s" % [time, string])

func open(path):
	if OS.shell_open(path) == OK:
		pass

func load_scene(path):
	if get_tree().change_scene(path) == OK:
		pass

