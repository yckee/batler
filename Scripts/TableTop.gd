extends Node2D

const BoardScene = preload("res://Scenes/Board.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for tile in $Board.tiles[-1]:
		$Board.spawn_piece(tile)
	for tile in $PieceHolder.tiles[-1]:
		$PieceHolder.spawn_piece(tile)


func execute_turn():
	var row = $Board.tiles[-1]
	var curr_tile
	var tile_to_place

	if $Board.pieces.size() > 0:
		$Board.advance_pieces()
		await $Board.advanced
	

	for piece in $PieceHolder.pieces:
		curr_tile = piece.placed_at
		tile_to_place = row[curr_tile.tile_pos.x]
		piece = $PieceHolder.take_piece(piece)
		$Board.place_piece(piece, tile_to_place)
	$PieceHolder.pieces = []
