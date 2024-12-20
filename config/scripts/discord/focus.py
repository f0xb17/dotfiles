#!/usr/bin/env python3
import subprocess
from libqtile.command.client import InteractiveCommandClient

def is_process_running(process_name):
    try:
        output = subprocess.check_output(["ps", "aux"], text=True)
        return process_name in output
    except subprocess.CalledProcessError:
        return False

def focus_discord_workspace():
    c = InteractiveCommandClient()
    discord_window = None
    for window in c.windows():
        wm_class = window['wm_class']
        if wm_class and any("discord" in cls.lower() for cls in wm_class):
            discord_window = window
            break

    if discord_window:
        c.group[discord_window['group']].toscreen()

def main():
    discord_running = is_process_running("discord")
    discord_canary_running = is_process_running("discord-canary")

    if discord_running or discord_canary_running:
        focus_discord_workspace()
        print("Focused on Discord workspace")
    else:
        print("Discord is not running")

if __name__ == "__main__":
    main()
