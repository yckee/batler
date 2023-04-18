extends Control

var deck := []
var rng := RandomNumberGenerator.new()

signal perk_purchased

func _ready():
	init_perks()
	rng.randomize()
	init_deck(10)
	roll()


func init_perks():
	for perk in $Grid/Perks.get_children():
		perk.perk_clicked.connect(_on_perk_clicked)

func init_deck(deck_size):
	for i in range(deck_size):
		deck.append(rng.randi_range(1,3))
	
func roll():
	print(deck)
	for perk in $Grid/Perks.get_children():
		var new_perk_type = deck.pop_at(randi() % deck.size())
		var old_perk_type = perk.perk_type
		
		perk.perk_type = new_perk_type
		if old_perk_type != PerkDB.PERKS.blank:
			deck.append(old_perk_type)
		

func buy(perk):
	emit_signal("perk_purchased", perk.perk_type)
	perk.perk_type = PerkDB.PERKS.blank

func _on_perk_clicked(perk):
	buy(perk)

func _on_reroll_but_pressed():
	roll()
