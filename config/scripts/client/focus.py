#!/usr/bin/env python
import argparse
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

def main():
    parser = argparse.ArgumentParser(description="Focus a specific client window in qtile")
    parser.add_argument('--client', type=str, required=True, help="Name of the client to focus")
    
    args = parser.parse_args()
    client_name = args.client

    focused = focus_client(client_name)
    
if __name__ == "__main__":
    main()
