extends StaticBody2D

var points = 10
onready var _target = position

var _dying = 0.0
var _dying_delta = 0.1
var _dying_color_delta = 0.05
var _dying_rotate = 0.0
var _dying_rotate_delta = rand_range(-0.03,0.03) 
var _dying_threshold = 10

onready var timer = $Timer

func _ready():
	randomize()
	position.y = -100
	position.x = 200
	var time = rand_range(0,1)
	timer.set_wait_time(time)
	timer.start()
	yield(timer, "timeout")
	$Tween.interpolate_property(self, "position", position, _target, 3.5, Tween.TRANS_CIRC,Tween.EASE_OUT)
	$Tween.interpolate_property(self, "position", position, _target, 3.5, Tween.TRANS_BOUNCE,Tween.EASE_OUT)
	$Tween.start()
	
func _process(delta):
	if _dying > 0:
		_dying += _dying_delta
		position.y += _dying
		rotate(_dying_rotate)
		_dying_rotate += _dying_rotate_delta
		$ColorRect.color = $ColorRect.color.linear_interpolate(Color(0,0,0,0),_dying_color_delta)
	if _dying > _dying_threshold:
		queue_free()
	

func kill():
	_dying += _dying_delta
	$CollisionShape2D.queue_free()
