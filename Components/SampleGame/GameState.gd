class_name GameState

enum StateType {
	WAIT = 0,
	PLAYER_TURN = 1,
}

var _current_state: StateType
var _previous_state: StateType

signal new_state_started

func _init():
	set_state_wait()

func is_player_turn() -> bool:
	return _current_state == StateType.PLAYER_TURN

func set_state_wait():
	_change_state(StateType.WAIT)

func set_state_player_turn():
	_change_state(StateType.PLAYER_TURN)

func _change_state(_new_state: StateType):
	if _current_state == _new_state: return
	# print("GameState._change_state: ", EnumUtils.get_string_name_from_value(StateType, _new_state))
	_previous_state = _current_state
	_current_state = _new_state
	new_state_started.emit(_current_state)
