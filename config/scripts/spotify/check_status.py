#!/usr/bin/env python3
import subprocess

def is_process_running(process_name):
    try:
        output = subprocess.check_output(["ps", "aux"], text=True)
        return process_name in output
    except subprocess.CalledProcessError:
        return False

def get_obs_icon():
    spotify = is_process_running("spotify")

    if spotify:
        icon = ""
    else:
        icon = ""

    return icon

def main():
    icon = get_obs_icon()
    print(icon)

if __name__ == "__main__":
    main()
