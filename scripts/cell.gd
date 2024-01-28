class_name Cell
extends Node


var row:int
var column:int
var north:Cell
var south:Cell
var east:Cell
var west:Cell
var linked_cells:Dictionary


func _init(_row:int, _col:int)->void:
	row = _row
	column = _col
	linked_cells = {}


func link(cell:Cell, bidi:bool = true)->Cell:
	if cell == null: return self
	linked_cells[cell] = true
	if bidi: cell.link(self, false)
	return self


func unlink(cell:Cell, bidi:bool = true)->Cell:
	if cell == null: return self
	assert(linked_cells.erase(cell))
	if bidi: cell.unlink(self, false)
	return self


func links()->Array[Cell]:
	return linked_cells.keys()


func is_linked(cell:Cell)->bool:
	return linked_cells.has(cell)


func neighbors()->Array[Cell]:
	var list:Array[Cell] = []
	if north: list.append(north)
	if south: list.append(south)
	if east: list.append(east)
	if west: list.append(west)
	return list
