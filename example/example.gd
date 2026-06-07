extends Control
## This file acts as an example of how to use the Spectre Logger.

func _ready() -> void:
	# Below are all the Spectre Logging functions, they optionally take a channel argument.
	Spectre.debug("Debug message") # Spectres a DEBUG message.
	Spectre.info("Hello there!") # Spectres an INFO message.
	Spectre.warn("Unexpected introduction detected") # Spectres a WARN message.
	Spectre.error("Failed to provide adequate response") # Spectres an ERROR message.
	Spectre.critical("Entered a State that is impossible, crashing...") # Spectres a CRITICAL message.
	# OS.crash("See Above") # Uncomment this line for a manual crash (FAIL-FAST)
	Spectre.force_flush() # Forcibly flushes the file.

	# Can mute individual channels so Spectres don't show up for them.
	Spectre.mute_channel(Spectre.AUDIO)
	Spectre.error("Trying to Spectre something for AUDIO", Spectre.AUDIO)
	Spectre.unmute_channel(Spectre.AUDIO)
	Spectre.error("This one it should actually log", Spectre.AUDIO)
	Spectre.force_flush()

	# Or mute all channels
	Spectre.mute_all()
	Spectre.info("This should not be logged")
	Spectre.info("This neither", Spectre.RENDER)
	Spectre.unmute_all()
	Spectre.info("Now this should show up again.")
	Spectre.info("And also this...", Spectre.RENDER)

	# When the engine crashes all Spectres that haven't been flushed yet are flushed.
	Spectre.info("Now this should be logged too when the engine crashes naturally.")
	Spectre.debug("And this too.")
	var crash_array: Array = []

	# For the sake of seeing the printed values we'll wait a second here.
	await get_tree().create_timer(0.5).timeout

	@warning_ignore("unused_variable")
	var foo = crash_array[0] # This should crash the engine.
