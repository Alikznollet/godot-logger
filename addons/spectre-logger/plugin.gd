@tool
extends EditorPlugin

func _enter_tree() -> void:
	# Add all of the settings
	_add_setting(
		SpectrePaths.LOG_ENABLED_SETTING,
		true,
		TYPE_BOOL
	)
	_add_setting(
		SpectrePaths.LOG_DIR_SETTING,
		"user://logs/",
		TYPE_STRING,
		PROPERTY_HINT_DIR
	)
	_add_setting(
		SpectrePaths.LOG_EXTENSION_SETTING,
		"log",
		TYPE_STRING
	)
	_add_setting(
		SpectrePaths.MAX_FILES_SETTING,
		5,
		TYPE_INT,
		PROPERTY_HINT_RANGE,
		"1,50,1"
	)
	_add_setting(
		SpectrePaths.MAX_BUFFER_SIZE_SETTING,
		10,
		TYPE_INT,
		PROPERTY_HINT_RANGE,
		"1,50,1"
	)
	_add_setting(
		SpectrePaths.SHOW_PID_IN_PRINT_SETTING,
		false,
		TYPE_BOOL
	)
	_add_setting(
		SpectrePaths.MIN_LOG_LEVEL_SETTING,
		Spectre.Event.DEBUG,
		TYPE_INT,
		PROPERTY_HINT_ENUM,
		"Debug,Info,Warn,Error,Critical"
	)

	# Color settings
	_add_setting(
		SpectrePaths.COLOR_DEBUG_SETTING,
		Color.LIGHT_BLUE,
		TYPE_COLOR
	)
	_add_setting(
		SpectrePaths.COLOR_INFO_SETTING,
		Color.DARK_SEA_GREEN,
		TYPE_COLOR
	)
	_add_setting(
		SpectrePaths.COLOR_WARN_SETTING,
		Color.GOLDENROD,
		TYPE_COLOR
	)
	_add_setting(
		SpectrePaths.COLOR_ERROR_SETTING,
		Color.TOMATO,
		TYPE_COLOR
	)
	_add_setting(
		SpectrePaths.COLOR_CRITICAL_SETTING,
		Color.CRIMSON,
		TYPE_COLOR
	)

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass

## Adds a setting to the ProjectSettings.
func _add_setting(name: String, default: Variant, type: int, hint: int = PROPERTY_HINT_NONE, hint_string: String = "") -> void:
	# Check if already exists.
	if not ProjectSettings.has_setting(name):
		ProjectSettings.set_setting(name, default)

	# Tell how to display the value
	var property_info := {
		"name": name,
		"type": type,
		"hint": hint,
		"hint_string": hint_string
	}
	ProjectSettings.add_property_info(property_info)

	# Set the default value
	ProjectSettings.set_initial_value(name, default)

	# Set as a basic setting
	ProjectSettings.set_as_basic(name, true)
