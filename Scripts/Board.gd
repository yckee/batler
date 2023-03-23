extends Node2D
class_name Board

const BoardTileScene = preload("res://Scenes/BoardTile.tscn")
const PieceScene = preload("res://Scenes/Piece.tscn")
@export var board_size: Vector2
@export var tile_type: String

# NOTE: tiles are stored in [row][col] format for easier row manipilations
#       e.g. [tile_pos.y][tile_pos.x]
var tiles: Array  
var pieces: Array

signal advanced

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
			tiles[row][col] = tile
			add_child(tile)


func spawn_piece(tile):
	var piece = PieceScene.instantiate()
	
	piece.add_to_group("Player_Pieces")
	
	place_piece(piece, tile)


func remove_piece(tile):
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


func move_piece(piece, direction, num_tiles):
	var dest = piece.placed_at.tile_pos + (Piece.MOVE_DIRACTIONS[direction] * num_tiles)

	if _is_on_grid(dest):
		var tile_to_move = tiles[dest.y][dest.x]
		var cur_tile_pos = piece.placed_at.tile_pos
		if !tile_to_move.object_on_tile:
				piece.move_piece(direction, num_tiles)
				tile_to_move.object_on_tile = piece
				piece.placed_at = tile_to_move
				tiles[cur_tile_pos.y][cur_tile_pos.x].object_on_tile = null
				
	
	

func advance_pieces():
	var moving
	for row in tiles:
		moving = false
		for tile in row:
			if tile.object_on_tile:
				move_piece(tile.object_on_tile, "up", 1)
				moving = true
		if moving:
			await SignalBus.move_piece_finished

	emit_signal("advanced")
	print("advanced")




func _is_on_grid(pos):
	return pos.x >= 0 and pos.y >= 0 and pos.x <= board_size.x and pos.y <= board_size.y

#func _input(event):
#	if event.is_action_pressed("ui_select"):
#		get_tree().call_group("Player_Pieces", "move_piece", "up", 1)
