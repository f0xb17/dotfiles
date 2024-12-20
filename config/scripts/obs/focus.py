#!/usr/bin/env python3
import subprocess
from libqtile.command.client import InteractiveCommandClient

def is_process_running(process_name):
    try:
        output = subprocess.check_output(["ps", "aux"], text=True)
        return process_name in output
    except subprocess.CalledProcessError:
        return False

def focus_obs_workspace():
    c = InteractiveCommandClient()
    obs_window = None
    for window in c.windows():
        wm_class = window['wm_class']
        if wm_class and any("obs" in cls.lower() for cls in wm_class):
            obs_window = window
            break

    if obs_window:
        c.group[obs_window['group']].toscreen()

def main():
    obs_studio_is_running = is_process_running("obs")

    if obs_studio_is_running:
        focus_obs_workspace()
        print("Focused on OBS workspace")
    else:
        print("OBS not running")

if __name__ == "__main__":
    main()
