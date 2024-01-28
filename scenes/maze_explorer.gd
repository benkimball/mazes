class_name MazeExplorer
extends ColorRect

@onready var maze:Maze = $Margin/Layout/Maze/Maze
@onready var algorithm_select:OptionButton = $Margin/Layout/UIContainer/FormContainer/AlgorithmSelect
@onready var num_cols:SpinBox = $Margin/Layout/UIContainer/FormContainer/NumCols
@onready var num_rows:SpinBox = $Margin/Layout/UIContainer/FormContainer/NumRows

const MAX_MAZE_SIDE_F:float = 1920.0
const MAZE_TILE_WIDTH:int = 128


func _ready()->void:
	algorithm_select.clear()
	var algorithms:Array[String] = maze.get_algorithms()
	if not algorithms.is_empty():
		for alg:String in maze.get_algorithms():
			algorithm_select.add_item(alg)
		generate_maze(10, 10, algorithms.front())


func generate_maze(cols:int, rows:int, algorithm:String)->void:
	var fx:float = MAX_MAZE_SIDE_F / (cols * MAZE_TILE_WIDTH)
	var fy:float = MAX_MAZE_SIDE_F / (rows * MAZE_TILE_WIDTH)
	maze.scale = Vector2(min(fx, fy), min(fx, fy))
	maze.generate(cols, rows, algorithm)


func _on_generate_button_pressed()->void:
	generate_maze(round(num_cols.value), round(num_rows.value), algorithm_select.text)
