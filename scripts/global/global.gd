extends Node

enum GAME_MODES {PVAI, PVP}

var mode: int = GAME_MODES.PVP

func _ready():
    print("Default Mode %s" % mode)

func set_mode(m: int) -> void:
    self.mode = m