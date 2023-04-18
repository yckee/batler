class_name PerkDB

enum PERKS {
	blank,
	special,
	stats,
	resist
}

const PERK_SPRITES = {
	PERKS.blank: preload("res://Assets/Perks/blank_perk.png"),
	PERKS.special: preload("res://Assets/Perks/rune_perk2.png"),
	PERKS.stats: preload("res://Assets/Perks/rune_perk3.png"),
	PERKS.resist: preload("res://Assets/Perks/rune_perk5.png"),
}
