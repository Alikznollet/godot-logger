# Spectre Logger for Godot

Spectre is a high-performance, multi-threaded logging utility for Godot 4. It intercepts standard engine outputs, provides detailed GDScript backtraces, and formats everything beautifully in both the editor console and external `.log` files without blocking your main game thread.

---

## ✨ Features

* **Multi-Threaded File Writing:** Writes logs to disk on a background thread to prevent game stuttering.
* **Engine Interception:** Automatically catches standard `print()` calls and internal Godot Engine errors/warnings.
* **Zero-Cost Kill Switch:** Disable the logger entirely via Project Settings. The internal "No-Op" architecture ensures all your `Spectre.info()` calls return instantly with zero performance hit, meaning you never have to strip logs out of your release builds.
* **Log Rotation:** Automatically cleans up old log files based on a configurable limit.
* **Custom Channels:** Categorize your logs (Physics, Network, UI, etc.) and mute/unmute them on the fly.
* **Rich Console Output:** Color-coded console messages based on log severity.
* **GDScript Backtraces:** Automatically appends the exact script trace when an `ERROR` or `CRITICAL` event occurs.

---

## 📦 Installation

### Releases/Cloning

1. Download/clone this repository.
2. Place the `spectre_logger` folder into your Godot project's `addons/` directory.
3. Open your project in the Godot Editor.
4. Go to **Project > Project Settings > Plugins**.
5. Find **Spectre Logger** and check if the **Enable** box is checked.

### Wisp

1. Make sure you have the [wisp CLI](https://www.github.com/alikznollet/godot-wisp) installed and have ran `wisp init` in your project.
2. Run:
```
wisp install alikznollet/godot-spectre
```
3. Open your project in the Godot Editor.
4. Go to **Project > Project Settings > Plugins**.
5. Find **Spectre Logger** and check if the **Enable** box is checked.

---

## 🚀 Quick Start

Because `Spectre` registers as a global `class_name`, you can call it from anywhere in your project without needing to load it.

```gdscript
# Standard logging (Defaults to the GENERAL channel)
Spectre.debug("Player loaded.")
Spectre.info("Connecting to server...")
Spectre.warn("Framerate dropped below 60!")
Spectre.error("Failed to load save file.")
Spectre.critical("Server disconnected unexpectedly!")
```

### Using Channels

You can route messages to specific sub-systems to filter the noise.

```gdscript
# Log a physics event
Spectre.info("Player collided with wall", Spectre.PHYSICS)

# Log a network event
Spectre.debug("Packet received: [142, 0, 9]", Spectre.NETWORK)

```

### Runtime Muting

Need to temporarily silence a noisy function without deleting your log calls? You can mute and unmute channels dynamically at runtime:

```gdscript
Spectre.mute_channel(Spectre.AUDIO)
# ... do noisy audio processing ...
Spectre.unmute_channel(Spectre.AUDIO)

# Or mute everything during a loading screen
Spectre.mute_all()
Spectre.unmute_all()

```

---

## ⚙️ Configuration

Spectre is highly customizable right out of the box. Once the plugin is enabled, go to **Project > Project Settings** and scroll down to **Addons > Spectre Logger** in the left sidebar.

From here, you can configure:

* **Is Enabled:** The master kill switch.
* **Log Directory:** Where your `.log` files are saved (defaults to `user://logs/`).
* **Min Log Level:** Ignore events below a certain severity (e.g., only log `WARN` and above).
* **Max Files:** How many old log files to keep before deleting them.
* **Max Buffer Size:** How many messages to queue before forcibly flushing to the disk.
* **Show PID in Print:** Toggle Process ID prefixes in the console.
* **Active Channels:** A convenient checklist of which channels should be active on startup.
* **Colors:** Customize the exact console colors for Debug, Info, Warn, Error, and Critical events!

---

## 🛑 Safe Shutdown

While Spectre handles standard Godot exits gracefully, if you are doing custom shutdown logic and need to guarantee that the final messages in the buffer are written to disk before the game window closes, call:

```gdscript
Spectre.shutdown()
```
