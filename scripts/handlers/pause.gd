extends Control

func _unhandled_input(event):
    if event is InputEventKey:
        if event.pressed and event.scancode == KEY_ESCAPE:
            if !get_tree().paused:
                print("game paused")
                self.visible = true
                get_tree().paused = true
            else:
                self.visible = false
                get_tree().paused = false
                print("game resumed")