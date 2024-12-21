import subprocess

def get_current_playing_track(player_name):
    try:
        status = subprocess.run(['playerctl', '-p', player_name, 'status'], capture_output=True, text=True).stdout.strip()

        if status == "Playing":
            artist = subprocess.run(['playerctl', '-p', player_name, 'metadata', 'xesam:artist'], capture_output=True, text=True).stdout.strip()
            title = subprocess.run(['playerctl', '-p', player_name, 'metadata', 'xesam:title'], capture_output=True, text=True).stdout.strip()
            return f"{artist} - {title}"

        return None
    except subprocess.CalledProcessError:
        return None

def main():
    players = subprocess.run(['playerctl', '-l'], capture_output=True, text=True).stdout.split()

    spotify_track = get_current_playing_track("spotify")
    if spotify_track:
        print(f"{spotify_track}")
        return

    for player in players:
        player = player.strip()
        if player != "spotify":
            track_info = get_current_playing_track(player)
            if track_info:
                print(f" {track_info}")
                return

    print("Nothing playing")

if __name__ == "__main__":
    main()
