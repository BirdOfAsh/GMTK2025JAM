extends Node

@export var puzzlesToComplete : int

var completedPuzzles : int = 0

var levelsDict : Dictionary[int, String] = {
	0 : "res://Levels/level_1.tscn",
	1 : "res://Levels/level_2.tscn",
	2 : "res://Levels/EndCredits/EndCredit.tscn"
}

func _ready() -> void:
	SignalBussin.connect("increaseCompletedPuzzle", increasePuzzleCount)
	SignalBussin.connect("decreaseCompletedPuzzle", decreasePuzzleCount)
	SignalBussin.connect("resetLoop", resetLoop)


func increasePuzzleCount():
	completedPuzzles += 1
	
	if completedPuzzles == puzzlesToComplete:
		progressToNextLoop()


func decreasePuzzleCount():
	if completedPuzzles > 0:
		completedPuzzles -= 1


func progressToNextLoop():
	for level in levelsDict:
			if levelsDict[level] == get_tree().current_scene.scene_file_path:
				get_tree().change_scene_to_file(levelsDict[level + 1])
				break


func resetLoop():
	get_tree().reload_current_scene()
