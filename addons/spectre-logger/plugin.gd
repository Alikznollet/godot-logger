@tool
extends EditorPlugin

func _enter_tree() -> void:
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
