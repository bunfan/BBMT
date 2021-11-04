extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# This function creates a label with text formatted for the BBMT UI
func create_label(text, size):
	# Add Label
	var label = Label.new()
	label.autowrap = true
	label.text = text
	label.align = 1
	label.valign = 1
	label.set_anchors_preset(15) #FULL_RECT

	var font = DynamicFont.new()
	font.font_data = load("res://assets/font/HelvetiPixel.ttf")
	font.size = size
	label.set("custom_fonts/font", font)
	return label