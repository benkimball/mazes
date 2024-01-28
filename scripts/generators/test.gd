class_name TestGenerator
extends BaseGenerator


func _init()->void:
	name = "Test"


func apply(grid:Grid)->void:
	grid.each_cell(func(c:Cell)->void:
		c.link(c.east)
		c.link(c.south)
	)
