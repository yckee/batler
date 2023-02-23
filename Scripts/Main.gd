extends Node2D

enum {
	BUY_PHASE,
	BATTLE_PHASE
}

var TURN_PHASE = BUY_PHASE


func _ready():
	$Board.connect("pieces_placed", self, "_pieces_placed")

func _process(_delta):
	match TURN_PHASE:
		BUY_PHASE:
			pass
		BATTLE_PHASE:
			$Board.advance_figures()
			TURN_PHASE = BUY_PHASE
			
func _pieces_placed(_board):
	print("placed")
	TURN_PHASE = BATTLE_PHASE
