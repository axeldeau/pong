extends Node2D

export var max_score: int = 7
export var delay: int = 3
var t: Timer
var main_scene = load("res://scenes/main.tscn")

func _init():
    t = Timer.new()
    t.one_shot = false
    t.name = "Timer"
    self.add_child(t)

func _enter_tree():
    run()

func run() -> void:
    place_players()
    countdown(delay)

func launch_timer(dur: int = 1) -> void:
    t.start(dur)

func countdown(delay: int = 3) -> void:
    var v: int = delay
    for _i in range(delay):
        $Countdown.text = str(v)
        v -= 1
        launch_timer()
        yield(t, "timeout")
    game_start()

func game_start() -> void:
    $Score1.visible = true
    $Score2.visible = true
    $Countdown.visible = false
    $Line2D.visible = true
    self.add_child(load("res://scenes/components/ball.tscn").instance())
    var ok :int = $Ball.connect("scored", self, "on_goal")
    if ok > 0:
        print(ok)
        print("Handle Ball.connect() error")

func on_goal(goal_name: String) -> void:
    print(goal_name)
    $Line2D.visible = false
    $Player1.free()
    $Player2.free()
    $Countdown.visible = true
    $Countdown.text = "GOAL"
    if goal_name == "Goal2":
        $Score1.text = str(int($Score1.text) + 1)
    else:
        $Score2.text = str(int($Score2.text) + 1)
    launch_timer(2)
    yield(t, "timeout")
    if !check_win():
        run()
    else:
        launch_timer(3)
        yield(t, "timeout")
        to_main()

func place_players() -> void:
    var p1: KinematicBody2D = load("res://scenes/components/player.tscn").instance()
    p1.set_name("Player1")
    p1.AI = false
    p1.position = Vector2(50.0, 270.0)
    var p2: KinematicBody2D = load("res://scenes/components/player.tscn").instance()
    p2.set_name("Player2")
    p2.AI = true
    p2.position = Vector2(1210.0, 270.0)
    add_child(p1)
    add_child(p2)

func check_win() -> bool:
    if int($Score1.text) == max_score:
        $Countdown.text = "P1 WINS"
        return true
    if int($Score2.text) == max_score:
        $Countdown.text = "P2 WINS"
        return true
    return false

func to_main() -> void:
    var ok = get_tree().change_scene_to(main_scene)
    if ok != 0:
        print("Handle change_scene_to() error")