class_name Maze
extends TileMap

const GENDIR:String = "res://scripts/generators"

var grid:Grid
var generators:Dictionary = {}


func _init()->void:
	for file_name:String in DirAccess.get_files_at(GENDIR):
		var Generator := load("%s/%s" % [GENDIR, file_name])
		var instance = Generator.new()
		if instance.include:
			generators[instance.name] = instance


func generate(cols:int, rows:int, generator_name:String)->void:
	grid = Grid.new(rows, cols)
	var generator:BaseGenerator = generators[generator_name]
	generator.apply(grid)
	queue_redraw()


func get_algorithms()->Array[String]:
	var algs:Array[String] = []
	for algorithm_name:String in generators.keys():
		algs.append(algorithm_name)
	return algs


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

