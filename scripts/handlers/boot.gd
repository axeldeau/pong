extends Control

func _ready():
    var t: Tween = get_parent().get_node('Tween')
    if t.interpolate_property(self, "color", Color("1f1f1f"), Color("1f1f1f"), 1.0, Tween.TRANS_CUBIC, Tween.EASE_OUT, 0.0):
        var b: bool = t.start()
        if !b:
            print("Handle Tween.start() error")
