#!/usr/bin/env python3
import subprocess

def get_active_player():
    result = subprocess.run(["playerctl", "-l"], stdout=subprocess.PIPE)
    players = result.stdout.decode('utf-8').split('\n')
    return players

def play_pause():
    players = get_active_player()
    if 'spotify' in players:
        subprocess.run(["playerctl", "-p", "spotify", "play-pause"])
    else:
        subprocess.run(["playerctl", "play-pause"])

if __name__ == "__main__":
    play_pause()
