# 🎙️ JARVIS Voice System Control Walkthrough

This document outlines the voice-controlled system commands supported by **MARK XLVIII (Jarvis)**. JARVIS uses the **Gemini Live API** to stream your voice, match your intent to a registered tool, and execute native actions across **Windows, macOS, and Linux**.

---

## 🛠️ How It Works (Under the Hood)

When you speak to JARVIS, the Gemini Live session maps your speech to one of four key system control tools declared in [main.py](file:///c:/Users/dushmanthm/Downloads/Mark%203/Mark-XLVIII-main/main.py):

1. **`open_app`**: Dedicated launcher for applications, sites, and settings panels.
2. **`computer_settings`**: Orchestrator for simple OS toggles (volume, brightness, power, shortcuts, wifi, window snapping).
3. **`computer_control`**: Direct inputs (keyboard presses, typing text, clipboard copy/paste, and AI-assisted screen clicking).
4. **`desktop_control`**: Operations related to the desktop background, folder organization, and generating custom desktop automation scripts.

---

## 🚀 Voice Control Walkthrough

### 1. Launching Applications (`open_app`)
JARVIS uses a list of popular aliases (Chrome, VSCode, Spotify, Word, Notepad, Task Manager, Settings, Calculator, etc.) and uses OS-specific launch sequences:
* **Windows**: Looks up executable paths in the system environment (`PATH`), starts URI schemes (e.g., `ms-settings:`), or fallback-searches via the Start Menu (pressing the Win key, typing the name, and hitting Enter) using PyAutoGUI.
* **macOS**: Runs `open -a <app_name>`. If it fails, Spotlight search is automatically used as a fallback.
* **Linux**: Runs desktop links, command line binaries (`gtk-launch` / `xdg-open`), or executes standard shortcuts.

> **Voice Examples:**
> * *"Jarvis, open Chrome"*
> * *"Launch Spotify"*
> * *"Open settings"*
> * *"Start visual studio code"*

---

### 2. Volume & Audio Control (`computer_settings`)
JARVIS adjusts volume either incrementally or by setting specific percentages:
* **Windows**: Adjusts master volumes natively using `pycaw` API or fallback PyAutoGUI volume keys.
* **macOS**: Invokes AppleScript (`osascript`) to set the audio level.
* **Linux**: Communicates directly with PulseAudio (`pactl set-sink-volume`).

> **Voice Examples:**
> * *"Turn up the volume"* / *"Mute the audio"*
> * *"Set volume to 50 percent"*
> * *"Quiet down"* (Gemini maps this intent using an internal intent-detection helper)

---

### 3. Brightness Control (`computer_settings`)
JARVIS controls your monitor brightness on the fly:
* **Windows**: Executes WMI PowerShell scripts (`(Get-WmiObject -Namespace root/wmi -Class WmiMonitorBrightnessMethods).WmiSetBrightness(...)`).
* **macOS**: Emulates brightness keystrokes via AppleScript.
* **Linux**: Adjusts brightness via `brightnessctl` or falls back to `xrandr`.

> **Voice Examples:**
> * *"Make the screen brighter"*
> * *"Lower screen brightness"*

---

### 4. Wi-Fi & Network Controls (`computer_settings`)
JARVIS can toggle your network card on or off:
* **Windows**: Disables or enables adapters matching the `Native 802.11` physical media type via PowerShell (`Disable-NetAdapter` / `Enable-NetAdapter`).
* **macOS**: Fetches your airport interface (e.g., `en0`) and toggles airport power (`networksetup -setairportpower`).
* **Linux**: Executes network manager commands (`nmcli radio wifi on/off`).

> **Voice Examples:**
> * *"Toggle Wi-Fi"*
> * *"Disconnect from Wi-Fi"*
> * *"Turn on Wi-Fi"*

---

### 5. Desktop Customization & Organization (`desktop_control`)
You can clean, sort, and organize the files cluttering your desktop, or change the wallpaper dynamically.
* **Wallpaper Change**: Set a wallpaper from a local path or download it from a URL and apply it (uses Windows API, macOS Finder settings, or Linux GNOME/KDE/XFCE configs).
* **Desktop Organizing**: Automatically sweeps up loose files on your desktop and sorts them into subfolders based on file extension (Images, Documents, Videos, Music, etc.) or modified dates.

> **Voice Examples:**
> * *"Organize my desktop by file type"*
> * *"Clean up my desktop"*
> * *"Set wallpaper from URL [url]"*
> * *"What are my desktop stats?"*

---

### 6. Power Management & Sleep (`computer_settings`)
You can shutdown, restart, lock, or sleep your system.
> [!IMPORTANT]
> **Safety Guard**: Shutdown and restart are guarded operations. When you issue a power command, JARVIS checks for a `confirmed` flag. If it is missing, JARVIS will ask you to confirm: *"This will shutdown/restart the computer. Please confirm by calling again with confirmed=yes."*

* **Screen Lock**: Locks the workstation immediately (Win+L on Windows, display sleep command on macOS, gnome/xdg lock on Linux).
* **Display Sleep**: Turns off the monitor display (Windows API `SendMessageW` display power message, display sleep on macOS, DPMS force off on Linux).

> **Voice Examples:**
> * *"Lock my screen"*
> * *"Turn off my display"*
> * *"Restart my computer"* *(requires voice confirmation)*

---

### 7. Keyboard Shortcuts & UI Control (`computer_control`)
You can emulate any keyboard shortcuts or hotkeys:
* **Window Navigation**: Alt+Tab, snapping windows left/right, maximizing/minimizing, closing current windows or tabs.
* **Scrolling & Page Navigation**: Scroll up, scroll down, zoom in/out/reset.
* **Basic Editing**: Undo, redo, cut, copy, paste, select all, save.

> [!TIP]
> **AI Screen-Clicking**: You can ask JARVIS to click on elements on the screen. It takes a screenshot, passes it to Gemini to locate the coordinates of the element you described, and uses `pyautogui` to click it.

> **Voice Examples:**
> * *"Minimize this window"*
> * *"Snap this window to the left"*
> * *"Scroll down"*
> * *"Click the 'Submit' button on my screen"*

---

## 💡 Pro Tips for Voice Interaction
1. **Natural Speech**: You don't need to speak rigid commands. Gemini routes your request dynamically. Saying *"It's too loud in here"* will be mapped by Gemini to a volume action.
2. **Instant Interrupts**: If JARVIS starts speaking or executing and you want to stop it, hit the **Escape** key or click the **INTERRUPT** button to halt execution in under 100 ms.
3. **Bilingual Commands**: JARVIS supports English and Turkish. If you speak Turkish, address JARVIS with **"efendim"**; if you speak English, address JARVIS with **"sir"**.
