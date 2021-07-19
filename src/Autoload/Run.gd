extends Node

# Checks for the mod directory
func setup():
	var dir = Directory.new()
	if dir.open(Data.mod_path) == OK:
		Base.log('Mod directory found! :D')
	else:
		Base.log('No mod directory found... Creating one')
		dir.make_dir(Data.mod_path)

# Creates folders and sub folders require for Beat Banger
func init_mod_folders(name):
	
	if name.length() < 1: return OS.alert('Please enter a name for your mod!')
	if !name.is_valid_filename(): return OS.alert('"%s" is not a valid name!' % name)

	Base.log('Creating "%s"' % name)

	var folders = [
		'/anims',
		'/anims/fx',
		'/sfx',
		'/songs',
		'/textures',
		'/voice'
	]
	
	Base.log('Creating directory tree')

	var dir = Directory.new();
	if dir.open(Data.mod_path) == OK:
		if dir.dir_exists(Data.mod_path + "/" + name): return OS.alert('Mod already exists!')
		dir.make_dir(name)
		for folder in folders:
			Base.log('Creating %s' % folder)
			dir.make_dir(name + folder)

	Base.load_scene('res://src/Creator/Creator.tscn')
		
