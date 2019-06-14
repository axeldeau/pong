extends Button

func _on_Quit_button_up():
    get_tree().set_auto_accept_quit(true)
    get_tree().quit()