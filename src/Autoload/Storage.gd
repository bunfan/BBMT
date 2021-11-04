extends Node

var mod_path = OS.get_user_data_dir() + "/mods"

var selected_beat: int = 0
var selected_node: Node

var current_beat = 0.0
var bpm: float = 128
var loop_speed: float = 1
var frame_rate_anim = 'loop_6'


var written_notes = []

var dialog_path = 'res://'

# Configuration Variables
var stage_name: String
var framerate: int

# Song Variables
var song_length_beats: int = 0 setget length_set

# Node Storage
var conductor: AudioStreamPlayer
var timeline: Panel

# This is a setter function that gets the length of the song in beat
# This is calculated in "Paramaters.gd" under the load_song() function
# This also calls the timeline to re-draw the notes
func length_set(value):
    song_length_beats = value
    print("Song length set to %s" % value)
    timeline.draw_notes()