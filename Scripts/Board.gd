extends Node2D

const BoardTileScene = preload("res://Scenes/BoardTile.tscn")
const PieceScene = preload("res://Scenes/Piece.tscn")
export var board_size = Vector2(6, 4)

signal pieces_placed

var move = {
	dir = "right",
	num_tiles = 1
}

var Grid = []

func _ready():
	for x in range(board_size.x):
		Grid.append([])
		for y in range(board_size.y):
			var tile = BoardTileScene.instance()
			tile.tile_size = 64
			tile.tile_pos = Vector2(x, y)
			tile.connect("piece_spawned", self, "spawn_piece")
			tile.connect("piece_removed", self, "remove_piece")
			Grid[x].append(tile)
			$Tiles.add_child(tile)

func find_piece_by_tile(tile):
	for piece in $Pieces.get_children():
		if piece.placed_at == tile: return piece


func spawn_piece(tile):
	var piece = PieceScene.instance()
	piece.texture_size = tile.tile_size
	piece.position = tile.position
	piece.placed_at = tile
	tile.is_empty = false
	piece.add_to_group("Black_Pieces")
	$Pieces.add_child(piece)


func remove_piece(tile):
	var piece = find_piece_by_tile(tile)
	piece.queue_free()
	tile.is_empty = true

func tile_exist(grid_pos):
	return grid_pos.x >= 0 and grid_pos.x < Grid.size() and grid_pos.y >= 0 and grid_pos.y < Grid[grid_pos.x].size()


func advance_figures():
	for piece in $Pieces.get_children():
		move_piece(piece)
		

func move_piece(piece):
	var tile = piece.placed_at
	var move_to = piece.placed_at.tile_pos + piece.MOVE_DIRACTIONS[move.dir]*move.num_tiles
	if tile_exist(move_to):
		var new_tile = Grid[move_to.x][move_to.y]
		tile.is_empty = true
		new_tile.is_empty = false
		piece.move_piece(move)
		piece.placed_at = new_tile
	

func _input(event):
	if event.is_action_pressed("ui_select"):
		print("signaling")
		emit_signal("pieces_placed", self)
