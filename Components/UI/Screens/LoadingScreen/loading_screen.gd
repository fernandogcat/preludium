class_name LoadingScreen
extends BaseScreen

signal loading_screen_coverage_completed

var intro_animation: String
var outro_animation: String

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var loading_icon: Control = %LoadingIcon
# TODO: remove progress bar?
@onready var progress_bar: ProgressBar = $Panel/ProgressBar

func setup(
	_intro_animation: String = LoadSceneManager.LOAD_ANIMATION_NONE,
	_outro_animation: String = LoadSceneManager.LOAD_ANIMATION_NONE
	):
	self.intro_animation = _intro_animation
	self.outro_animation = _outro_animation

func _ready():
	loading_icon.set_process(false)
	_start_intro_animation()

func _process(_delta):
	loading_icon.rotation_degrees += 10

func update_progress_bar(new_value: float):
	# progressLabel.text = str(int(new_value * 100)) + "%"
	progress_bar.set_value_no_signal(new_value * 100)

func _start_intro_animation():
	if intro_animation != LoadSceneManager.LOAD_ANIMATION_NONE:
		animation_player.play(intro_animation)
	else:
		loading_screen_coverage_completed.emit()

func start_outro_animation():
	if animation_player.is_playing():
		await animation_player.animation_finished
	if outro_animation != LoadSceneManager.LOAD_ANIMATION_NONE:
		animation_player.play(outro_animation)
		await animation_player.animation_finished
	queue_free()
