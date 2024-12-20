#!/usr/bin/env python3
import subprocess

def get_active_player():
    result = subprocess.run(["playerctl", "-l"], stdout=subprocess.PIPE)
    players = result.stdout.decode('utf-8').split('\n')
    return players

def get_player_status(player):
    result = subprocess.run(["playerctl", "-p", player, "status"], stdout=subprocess.PIPE)
    return result.stdout.decode('utf-8').strip()

def get_now_playing(player):
    title = subprocess.run(["playerctl", "-p", player, "metadata", "title"], stdout=subprocess.PIPE).stdout.decode('utf-8').strip()
    artist = subprocess.run(["playerctl", "-p", player, "metadata", "artist"], stdout=subprocess.PIPE).stdout.decode('utf-8').strip()
    return f"{artist} - {title}"

def display_now_playing():
    players = get_active_player()
    if 'spotify' in players:
        if get_player_status('spotify') == 'Playing':
            print(get_now_playing('spotify'))
            return
        players.remove('spotify')
    
    for player in players:
        if player:
            status = get_player_status(player)
            if status == 'Playing':
                print(get_now_playing(player))
                return

if __name__ == "__main__":
    display_now_playing()
