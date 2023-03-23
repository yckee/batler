extends "res://Scripts/Board.gd"

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


