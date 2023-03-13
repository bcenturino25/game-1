extends Node

func _on_playButton_pressed():
	get_tree().change_scene("res://scenes/main.tscn")
	
func _on_exitButton_pressed():
	get_tree().quit()

#This method runs when options button is pressed
func _on_optionsButton_pressed():
	get_tree().change_scene("res://scenes/instructions.tscn")
