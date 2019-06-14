extends KinematicBody2D

enum fsm {IDLE, UP, DOWN}

export var speed: float = 10.0
export var AI: bool = true

var boundary: Array
var state: int = 0

var input: Array

# Called when the node enters the scene tree for the first time.
func _ready():
    input = define_player_input()
    boundary = define_boundary()

func _physics_process(delta):
    if !AI:
        handle_user_input(delta)
    else:
        handle_ai_input(delta)

func _unhandled_input(event):
    if !AI:
        if event is InputEventKey:
            if event.pressed:
                var up: int = input[0]
                var down: int = input[1]
                match event.scancode:
                    up:
                        state = fsm.UP
                    down:
                        state = fsm.DOWN
            else:
                state = fsm.IDLE
                return

func within_boundary(pos: float) -> bool:
    return pos >= boundary[0] && pos <= boundary[1]

func round_position(pos: float) -> float:
    if pos < boundary[0]:
        return boundary[0]
    if pos > boundary[1]:
        return boundary[1]
    return pos

func handle_user_input(delta: float) -> void:
    if state != fsm.IDLE:
        if within_boundary(self.position.y):
            if state == fsm.UP:
                self.position.y = round_position(self.position.y - (speed * 100.0 * delta))
            if state == fsm.DOWN:
                self.position.y = round_position(self.position.y + (speed * 100.0 * delta))
        else:
            state = fsm.IDLE

func handle_ai_input(_delta: float) -> void:
    var ball = get_parent().get_node("Ball")
    if ball != null:
        self.position.y = round_position(ball.position.y - 90)

func define_player_input() -> Array:
    if self.name == "Player1":
        return [KEY_W, KEY_S]
    if !AI && self.name == "Player2":
        return [KEY_UP, KEY_DOWN]
    return []

func define_boundary() -> Array:
    return [0.0, OS.window_size.y - 180]

func set_ai(b: bool) -> void:
    self.AI = b 