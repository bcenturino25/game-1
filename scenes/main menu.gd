extends Node

func _on_playButton_pressed():
	get_tree().change_scene("res://scenes/main.tscn")
	
func _on_exitButton_pressed():
	get_tree().quit()

<<<<<<< HEAD
=======
#This method runs when options button is pressed
>>>>>>> f97d1c880b7d589a1fcc7e13a01c5d6196a930c7
func _on_optionsButton_pressed():
	get_tree().change_scene("res://scenes/instructions.tscn")
