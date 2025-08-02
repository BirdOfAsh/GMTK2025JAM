extends Node
var count: int = 0

func leverFlicked():
	count += 1
	
	if count == 3:
		allLeverFlicked()

func allLeverFlicked():
	get_parent().get_parent().find_child("LevelManager").increasePuzzleCount()
