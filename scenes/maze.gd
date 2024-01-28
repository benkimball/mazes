class_name Maze
extends TileMap

var grid:Grid
var algorithms:Dictionary = {
	"test": generate_test_pattern,
	"binary tree": generate_binary_tree,
	"sidewinder": generate_sidewinder
}

func _ready() -> void:
	generate(10, 10, "test")


func generate(cols:int, rows:int, algorithm:String)->void:
	assert(algorithms.has(algorithm))
	grid = Grid.new(rows, cols)
	algorithms[algorithm].call()
	queue_redraw()


func get_algorithms()->Array[String]:
	var algs:Array[String] = []
	for alg:String in algorithms.keys():
		algs.append(alg)
	return algs


func generate_test_pattern()->void:
	grid.each_cell(func(c:Cell)->void:
		c.link(c.east)
		c.link(c.south)
	)


func generate_binary_tree()->void:
	grid.each_cell(func(c:Cell)->void:
		var neighbors:Array[Cell] = []
		if c.north: neighbors.append(c.north)
		if c.east: neighbors.append(c.east)
		if neighbors.size() > 0:
			c.link(neighbors.pick_random())
	)

func generate_sidewinder()->void:
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
	
	
func _draw()->void:
	for rix:int in grid.rows:
		for cix:int in grid.columns:
			var c:Cell = grid.at(rix, cix)
			if not c: continue
			var v:Vector2i = Vector2i(cix, rix)
			var tile:Vector2i = get_tile_for_cell(c)
			set_cell(0, v, 0, tile)


func get_tile_for_cell(c:Cell)->Vector2i:
	var tile_mask:int = 0b1111
	if c.is_linked(c.north): tile_mask ^= 1
	if c.is_linked(c.east): tile_mask ^= 2
	if c.is_linked(c.south): tile_mask ^= 4
	if c.is_linked(c.west): tile_mask ^= 8
	@warning_ignore("integer_division")
	return Vector2i(tile_mask % 4, tile_mask / 4)

