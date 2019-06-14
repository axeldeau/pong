extends Node

##################################################################### Class
# Credit: https://www.freepik.com/
# Icon  : https://www.flaticon.com/free-icon/shuffle_1541012
# Helper Class providing various random functions
class_name Randomizer, "res://sprites/icons/random.png"

static func get_random(maximum: int = 1) -> int:
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    return rng.randi_range(0, maximum)

static func get_random_range(minimum: int = 0, maximum: int = 1) -> int:
    return get_random(maximum-minimum) + minimum

static func coin_flip() -> bool:
    var c: int = get_random(1)
    if c == 0:  
        return true
    return false