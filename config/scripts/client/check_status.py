#!/usr/bin/env python
import psutil, argparse

def is_process_currently_running(process_name):
    for process in psutil.process_iter(['name']):
        if process_name.lower() in process.info['name'].lower():
            return True
    return False

def main():
    parser = argparse.ArgumentParser(description="Check the status of a specific client window")
    parser.add_argument('--client', type=str, required=True, help="Name of the client to check")
    
    args = parser.parse_args()
    client_name = args.client

    currently_running = is_process_currently_running(client_name)
    if client_name == "spotify" and currently_running:
        print("")
    elif client_name == "obs" and currently_running:
        print("")
    elif client_name == "discord" and currently_running:
        print("")
    else:
        print("")

if __name__ == "__main__":
    main()
