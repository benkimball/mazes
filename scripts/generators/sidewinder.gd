class_name SidewinderGenerator
extends BaseGenerator


func _init()->void:
	name = "Sidewinder"


func apply(grid:Grid)->void:
	grid.each_row(func (row:Array[Cell])->void:
		var run:Array[Cell] = []
		for cell:Cell in row:
			run.append(cell)
			var at_eastern_boundary:bool = not cell.east
			var at_northern_boundary:bool = not cell.north
			var should_close = at_eastern_boundary or (!at_northern_boundary && randi_range(0, 1) == 0)
			if should_close:
				var sample:Cell = run.pick_random()
				sample.link(sample.north)
				run.clear()
			else:
				cell.link(cell.east)
	)
