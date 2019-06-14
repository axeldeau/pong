extends Node2D

var length: float = 2.0
var transparent: Color = Color(1, 1, 1, 0)
var full: Color = Color(1, 1, 1, 1)

onready var t: Tween = get_node('Tween')
var logo_array: Array = ["res://sprites/global/Godot.png", "res://sprites/global/dualition-logo.png"]
var next_scene = preload("res://scenes/main.tscn")


func _ready():
    loop_intro(logo_array)
    yield(t, "tween_all_completed")
    var ok = get_tree().change_scene_to(next_scene)
    if ok != 0:
        print("Handle change_scene_to() error")

func fade_in(sprite: Sprite) -> void:
    fade(transparent, full, length, sprite)

func fade_out(sprite: Sprite) -> void:
    fade(full, transparent, length, sprite)

func loop_intro(logo_array: Array) -> void:
    for resource in logo_array:
        var sprite: Sprite = set_logo(resource)
        # Add child
        add_child(sprite)
        fade_in(sprite)
        yield(t,"tween_completed")
        fade_out(sprite)
        yield(t,"tween_completed")
        # Free child
        sprite.free()

func set_logo(r: String) -> Sprite:
    var logo: Sprite = Sprite.new()
    logo.set_texture(load(r))
    logo.name = "Logo"
    logo.position = Vector2( OS.window_size.x /2, (OS.window_size.y /2)  )
    logo.modulate = transparent
    return logo

func fade(start: Color = Color(1, 1, 1, 0), end:Color = Color(1, 1, 1, 1), duration: float = length, l: Sprite = Sprite.new()) -> void:
    if t.interpolate_property(l, "modulate", start, end, duration, Tween.TRANS_BACK, Tween.EASE_IN):
        var b: bool = t.start()
        if !b:
            print("Handle Tween.start() error")