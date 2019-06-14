extends Control

var next_scene = preload("res://scenes/game.tscn")

func _ready():
     var t: Tween = $Tween
     if t.interpolate_property($ColorRect, "color", Color("1f1f1f"), Color(1, 1, 1, 0), 1.0, Tween.TRANS_BACK, Tween.EASE_IN):
        var b: bool = t.start()
        if !b:
            print("Handle Tween.start() error")

func _unhandled_input(event):
    if event is InputEventKey:
        if event.pressed and event.scancode == KEY_SPACE:
            Global.set_mode(Global.GAME_MODES.PVP)
        if event.pressed and event.scancode == KEY_ENTER:
            Global.set_mode(Global.GAME_MODES.PVAI)
        var ok = get_tree().change_scene_to(next_scene)
        if ok != 0:
            print("Handle change_scene_to() error")