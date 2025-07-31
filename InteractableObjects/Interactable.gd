class_name Interactable
extends Node

var rootNode
## Interaction Node must be placed as a child of the root node for that object it must not be a grandchild of an object
func _ready() -> void:
	rootNode = self.get_parent()

func interact(player : CharacterBody3D):
	## all root nodes will have a class to deal with interaction
	rootNode.call("interaction", player)
