#!/usr/bin/env python3
import subprocess

def is_process_running(process_name):
    try:
        output = subprocess.check_output(["ps", "aux"], text=True)
        return process_name in output
    except subprocess.CalledProcessError:
        return False

def get_discord_icon():
    discord_running = is_process_running("discord")
    discord_canary_running = is_process_running("discord-canary")

    if discord_running or discord_canary_running:
        icon = "" 
    else:
        icon = ""

    return icon

def main():
    icon = get_discord_icon()
    print(icon)

if __name__ == "__main__":
    main()
