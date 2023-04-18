extends Control


func _ready():
	$Shop.perk_purchased.connect($Inventory.add_perk)


