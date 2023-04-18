extends Node2D


enum {
	BUY_PHASE,
	BATTLE_PHASE
}

var state = BUY_PHASE

func _process(delta):
	match state:
		BUY_PHASE:
			# ToDo: restrict access to shop after buy phase is over
			$Forge.set_process(true) 
		BATTLE_PHASE:
			$TableTop.execute_turn()
			state = BUY_PHASE
			
			

func _input(event):
	if event.is_action_pressed("advance"):
		state = BATTLE_PHASE

