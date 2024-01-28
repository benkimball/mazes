class_name BinaryTreeGenerator
extends BaseGenerator


func _init()->void:
	name = "Binary Tree"


func apply(grid:Grid)->void:
	grid.each_cell(func(c:Cell)->void:
		var neighbors:Array[Cell] = []
		if c.north: neighbors.append(c.north)
		if c.east: neighbors.append(c.east)
		if neighbors.size() > 0:
			c.link(neighbors.pick_random())
	)
