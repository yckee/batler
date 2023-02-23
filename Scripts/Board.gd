extends Node2D

const BoardTileScene = preload("res://Scenes/BoardTile.tscn")
const PieceScene = preload("res://Scenes/Piece.tscn")
export var board_size = Vector2(6, 4)


func _ready():
	for x in range(board_size.x):
		for y in range(board_size.y):
			var tile = BoardTileScene.instance()
			tile.tile_size = 64
			tile.tile_pos = Vector2(x, y)
			tile.connect("piece_spawned", self, "spawn_piece")
			tile.connect("piece_removed", self, "remove_piece")
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

func _input(event):
	if event.is_action_pressed("ui_select"):
		get_tree().call_group("Black_Pieces", "move_piece", "right", 1)
