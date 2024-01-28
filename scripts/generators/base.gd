class_name BaseGenerator
extends Resource

var name:String
var include:bool = true


func _init()->void:
	name = "Base"
	include = false


func apply(_grid:Grid)->void:
	pass
