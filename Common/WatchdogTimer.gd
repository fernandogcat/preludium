class_name WatchdogTimer

var _watchdog_timer: SceneTreeTimer
var timeout := 0.6

func start_timer():
	# don't put this timeout too low becuase depending on the hardware it could be too fast and provoke a false positive timeout
	if _watchdog_timer != null:
		# print("Watchdog timer reset")
		_watchdog_timer.time_left = timeout
	else:
		_watchdog_timer = Globals.get_tree().create_timer(timeout)
		_watchdog_timer.connect("timeout", _on_timer_timeout)
		# print("Watchdog timer start. name: ", self.to_string())
		await _watchdog_timer.timeout

func cancel_timer():
	# print("Watchdog timer cancel. name: ", self.to_string())
	if _watchdog_timer == null: return
	_watchdog_timer.disconnect("timeout", _on_timer_timeout)
	_watchdog_timer.cancel_free()
	_watchdog_timer = null

func _on_timer_timeout():
	# print("Watchdog timer timeout. name: ", self.to_string())
	_watchdog_timer = null
	assert(false, "Watchdog timer timeout")
