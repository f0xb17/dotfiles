#!/usr/bin/env python
import argparse, subprocess, os, importlib.util

def is_module_installed(module_name):
    return importlib.util.find_spec(module_name) is not None

def get_window_manager_name():
    try:
        result = subprocess.run(['wmctrl', '-m'], capture_output=True, text=True, check=True)
        for line in result.stdout.split('\n'):
            if line.startswith('Name:'):
                return line.split(':')[1].strip()
    except subprocess.CalledProcessError:
        return None

def focus_client(client_name):
    from libqtile.command.client import InteractiveCommandClient
    c = InteractiveCommandClient()
    for window in c.windows():
        wm_class = window['wm_class']
        if wm_class and any(client_name in cls.lower() for cls in wm_class):
            c.group[window['group']].toscreen()
            return

def main():
    parser = argparse.ArgumentParser(description="Focus a specific client window in qtile")
    parser.add_argument('--client', type=str, required=True, help="Name of the client to focus")
    
    args = parser.parse_args()
    client_name = args.client
    current_directory = os.path.join(os.path.dirname(os.path.realpath(__file__)), "focus.sh")

    if get_window_manager_name() == "bspwm":
        subprocess.run([current_directory, client_name], capture_output=True, text=True, check=True)
    elif is_module_installed('libqtile') and get_window_manager_name() == "qtiled":
        focus_client(client_name)
    
if __name__ == "__main__":
    main()
