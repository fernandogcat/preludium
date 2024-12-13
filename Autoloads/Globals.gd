extends Node

# TODO: hacerlo autoload? quizás con scene+resource? pq este globals no tiene mucho sense
var config: GameConfiguration

func setup(_config: GameConfiguration):
	config = _config
