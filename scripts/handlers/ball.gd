extends KinematicBody2D

export var speed: float = 10.0

var direction: bool
var target: float = 0.0
var middle: Vector2

signal scored(player_name)

func _init():
    direction = Randomizer.coin_flip()

func _ready():
    middle = Vector2(OS.window_size.x/2, OS.window_size.y/2)
    if direction:
        self.position = Vector2(middle.x + 40, middle.y)
    else:
        self.position = Vector2(middle.x - 40, middle.y)

func _physics_process(delta):
    var motion: Vector2
    # Left and Right
    if direction:
        motion = Vector2(100.0 * delta * speed, -target * delta * speed)
    else:
        motion = Vector2(-100.0 * delta * speed, -target * delta * speed)
    var info = move_and_collide(motion)
    if info != null:
        var p: KinematicBody2D = info.get_collider()
        if p.get_name() == "Player1" || p.get_name() == "Player2":
            direction = !direction
            var h: int
            if p.get_name() == "Player1":
                h = info.position.y - 10
            else:
                h = info.position.y + 10
            target = h - (p.get_position().y + 90)
        if info.get_collider_shape().get_name() == "Down" || info.get_collider_shape().get_name() == "Top":
            target = -target
        if info.get_collider_shape().get_name() == "Goal1" || info.get_collider_shape().get_name() == "Goal2":
            emit_signal("scored", info.get_collider_shape().get_name())
            queue_free()