extends Control

var next_scene = preload("res://scenes/promotion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
#     var t: Tween = $Tween
#     yield(t,"tween_started")
#     var ok :int = t.connect("tween_completed", self, "on_tween_completed")
#     if ok > 0:
#         print(ok)
#         print("Handle Tween.connect() error")

# func on_tween_completed(_obj, _node):
    var ok = get_tree().change_scene_to(next_scene)
    if ok != 0:
        print("Handle change_scene_to() error")