extends Button

func _on_Resume_button_up():
    self.get_parent().get_parent().visible = false
    get_tree().paused = false
    print("game resumed")