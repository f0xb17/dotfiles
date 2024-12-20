import subprocess

def get_current_playing_track():
    try:
        spotify_status = subprocess.run(['playerctl', '-p', 'spotify', 'status'], capture_output=True, text=True).stdout.strip()
        
        if spotify_status == "Playing":
            spotify_artist = subprocess.run(['playerctl', '-p', 'spotify', 'metadata', 'xesam:artist'], capture_output=True, text=True).stdout.strip()
            spotify_title = subprocess.run(['playerctl', '-p', 'spotify', 'metadata', 'xesam:title'], capture_output=True, text=True).stdout.strip()
            return f"{spotify_artist} - {spotify_title}"

        players = subprocess.run(['playerctl', '-l'], capture_output=True, text=True).stdout.split()
        for player in players:
            if player == "spotify":
                continue

            status = subprocess.run(['playerctl', '-p', player, 'status'], capture_output=True, text=True).stdout.strip()
            if status == "Playing":
                artist = subprocess.run(['playerctl', '-p', player, 'metadata', 'xesam:artist'], capture_output=True, text=True).stdout.strip()
                title = subprocess.run(['playerctl', '-p', player, 'metadata', 'xesam:title'], capture_output=True, text=True).stdout.strip()
                return f"{artist} - {title}"

        return "Empty Track"
    except subprocess.CalledProcessError:
        return "Empty Track"

if __name__ == "__main__":
    print(get_current_playing_track())
