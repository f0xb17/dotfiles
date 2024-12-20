#!/usr/bin/env python3
import subprocess
from libqtile.command.client import InteractiveCommandClient

def is_process_running(process_name):
    try:
        output = subprocess.check_output(["ps", "aux"], text=True)
        return process_name in output
    except subprocess.CalledProcessError:
        return False

def focus_spotify_workspace():
    c = InteractiveCommandClient()
    spotify_window = None
    for window in c.windows():
        wm_class = window['wm_class']
        if wm_class and any("spotify" in cls.lower() for cls in wm_class):
            spotify_window = window
            break

    if spotify_window:
        c.group[spotify_window['group']].toscreen()

def main():
    spotify_is_running = is_process_running("spotify")

    if spotify_is_running:
        focus_spotify_workspace()
        print("Focused on Spotify workspace")
    else:
        print("Spotify not running")

if __name__ == "__main__":
    main()
