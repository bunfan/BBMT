extends Node


var mod_path = OS.get_user_data_dir() + "/mods"

var selected_beat: int = 0
var selected_node: Node

var current_beat = 0.0
var bpm: float = 128
var loop_speed: float = 1
var frame_rate_anim = 'loop_6'

var song_length: int = 0
var written_notes = []

var dialog_path = 'res://'