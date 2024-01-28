class_name Grid
extends Node

var rows:int
var columns:int
var grid:Array


func _init(_rows:int, _columns:int)->void:
	rows = _rows
	columns = _columns
	grid = prepare_grid()
	configure_cells()


func prepare_row(row_index:int)->Array[Cell]:
	var row:Array[Cell] = []
	for cix:int in columns:
		row.append(Cell.new(row_index, cix))
	return row


func prepare_grid()->Array:
	return range(rows).map(prepare_row)


func each_cell(c:Callable)->void:
	for row:Array[Cell] in grid:
		for cell:Cell in row:
			c.call(cell)


func each_row(c:Callable)->void:
	for row:Array[Cell] in grid:
		c.call(row)


func at(row:int, col:int)->Cell:
	if row < 0 or row >= grid.size(): return null
	if col < 0 or col >= grid[row].size(): return null
	return grid[row][col]


func configure_cells()->void:
	each_cell(func(c:Cell)->void:
		var row:int = c.row
		var col:int = c.column
		c.north = at(row - 1, col)
		c.south = at(row + 1, col)
		c.east = at(row, col + 1)
		c.west = at(row, col - 1)
	)


func random_cell()->Cell:
	var row:int = randi_range(0, grid.size() - 1)
	var col:int = randi_range(0, grid[row].size() - 1)
	return grid[row][col]


func size()->int:
	return rows * columns
