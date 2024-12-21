#!/usr/bin/env python
import argparse, subprocess, os, importlib.util

def is_module_installed(module_name):
    spec = importlib.util.find_spec(module_name)
    return spec is not None

if is_module_installed('libqtile'):
    from libqtile.command.client import InteractiveCommandClient

    def focus_client(client_name):
        c = InteractiveCommandClient()
        client_window = None
        for window in c.windows():
            wm_class = window['wm_class']
            if wm_class and any(client_name in cls.lower() for cls in wm_class):
                client_window = window
                break

        if client_window:
            c.group[client_window['group']].toscreen()

def get_window_manager_name():
    try:
        result = subprocess.run(['wmctrl', '-m'], capture_output=True, text=True, check=True)
        for line in result.stdout.split('\n'):
            if line.startswith('Name:'):
                wm_name = line.split(':')[1].strip()
                return wm_name
    except subprocess.CalledProcessError:
        return None

def focus_client(client_name):
    c = InteractiveCommandClient()
    client_window = None
    for window in c.windows():
        wm_class = window['wm_class']
        if wm_class and any(client_name in cls.lower() for cls in wm_class):
            client_window = window
            break

    if client_window:
        c.group[client_window['group']].toscreen()

def main():
    parser = argparse.ArgumentParser(description="Focus a specific client window in qtile")
    parser.add_argument('--client', type=str, required=True, help="Name of the client to focus")
    
    args = parser.parse_args()
    client_name = args.client
    current_directory = os.path.dirname(os.path.realpath(__file__)) + "/focus.sh"

    if get_window_manager_name() == "bspwm":
        subprocess.run([current_directory, client_name], capture_output=True, text=True, check=True)
    else:
        if is_module_installed('libqtile'):
            focused = focus_client(client_name)
        else:
            return
    
if __name__ == "__main__":
    main()
