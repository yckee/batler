extends Node2D

const BoardTileScene = preload("res://Scenes/BoardTile.tscn")
const PieceScene = preload("res://Scenes/Piece.tscn")
@export var board_size: Vector2
@export var tile_type: String

# NOTE: tiles are stored in [row][col] format for easier row manipilations
#       e.g. [tile_pos.y][tile_pos.x]
var tiles: Array  
var pieces: Array

signal advance_finished

func _ready():
	# init empty 2D Array of tiles
	for row in range(board_size.y):
		tiles.append([])
		for col in range(board_size.x):
			tiles[row].append(null)
	
	init_board()


func init_board():
	"""
	Fills tiles array with BoardTiles
	"""
	
	for row in range(board_size.y):
		for col in range(board_size.x):
			var tile = BoardTileScene.instantiate()
			tile.tile_size = 64
			tile.tile_pos = Vector2(col, row)
			tile.tile_type = tile_type
			tile.connect("piece_spawned",Callable(self,"spawn_piece"))
			tile.connect("piece_removed",Callable(self,"remove_piece"))
			tiles[row][col] = tile
			add_child(tile)


func spawn_piece(tile):
	var piece = PieceScene.instantiate()
	
	piece.add_to_group("Player_Pieces")
	
	place_piece(piece, tile)


func remove_piece(tile):
	print(tile.tile_pos)
	var piece = tile.object_on_tile
	piece.queue_free()
	tile.object_on_tile = null


func place_piece(piece, tile):
	piece.texture_size = tile.tile_size
	piece.position = tile.position
	piece.placed_at = tile
	tile.object_on_tile = piece
	pieces.append(piece)
	add_child(piece)
	
func take_piece(piece) -> Piece:
	var tile = piece.placed_at
	
	tile.object_on_tile = null
	piece.placed_at = null
	remove_child(piece)
	
	return piece
	

func advance_pieces():
	for piece in pieces:
		piece.move_piece("up", 1)
	
	emit_signal("advance_finished")
#	yield(, "Move_Piece_Finished")

func _input(event):
	if event.is_action_pressed("ui_select"):
		get_tree().call_group("Player_Pieces", "move_piece", "up", 1)
