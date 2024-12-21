import subprocess

def get_current_layout():
    result = subprocess.run(['setxkbmap', '-query'], capture_output=True, text=True)
    for line in result.stdout.split('\n'):
        if 'layout' in line:
            return line.split()[-1]

def set_layout(layout):
    subprocess.run(['setxkbmap', layout])

def toggle_layout():
    current_layout = get_current_layout()
    if current_layout == 'us':
        set_layout('de')
    else:
        set_layout('us')

if __name__ == "__main__":
    toggle_layout()
