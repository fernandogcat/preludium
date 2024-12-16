class_name GameConfiguration
extends Resource

const EXPORT_GROUP_GAME_SETTINGS = "Game Settings"
const EXPORT_GROUP_BUILD_SETTINGS = "Build Settings"
const EXPORT_GROUP_DEV_SETTINGS = "DEV Settings"

# @export_group(EXPORT_GROUP_GAME_SETTINGS)


@export_group(EXPORT_GROUP_BUILD_SETTINGS)

# TODO: append type of build
var version: String
# TODO: create buildtype enum

@export_group(EXPORT_GROUP_DEV_SETTINGS)

@export var quick_skip_main_screen: bool
@export var quick_exit_game: bool

func _init():
	version = ProjectSettings.get_setting("application/config/version")
	print("Version %s, is_release_build? %s" % [version, is_release_build()])

func is_release_build() -> bool:
	return !OS.is_debug_build()

func setup():
	_prepare_configuration()

func _prepare_configuration():
	if is_release_build():
		_disable_dev_setting_properties()

func _disable_dev_setting_properties():
	var props = get_property_list()
	var dev_settings_group_started := false
	for prop in props:
		if prop.usage & PROPERTY_USAGE_GROUP and prop.name == EXPORT_GROUP_DEV_SETTINGS:
			dev_settings_group_started = true
			continue
		if dev_settings_group_started and prop.usage & PROPERTY_USAGE_GROUP:
			# another group found, stop disabling properties
			dev_settings_group_started = false
			break
		if dev_settings_group_started:
			set(prop.name, false)
