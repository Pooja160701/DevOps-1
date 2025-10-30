#!/usr/bin/env python3
import requests
import argparse
import datetime

# Argument parser
parser = argparse.ArgumentParser(description="Application Health Checker")
parser.add_argument("--url", required=True, help="URL of the application to check")
args = parser.parse_args()

# Log file name
log_file = "app_health.log"

def log_message(message):
    with open(log_file, "a") as f:
        f.write(f"{datetime.datetime.now()} - {message}\n")

try:
    response = requests.get(args.url, timeout=5)
    status_code = response.status_code

    if status_code == 200:
        msg = f"Application is UP! ({args.url}) - Status Code: {status_code}"
    else:
        msg = f"Application returned unexpected status code {status_code} ({args.url})"

except requests.exceptions.RequestException as e:
    msg = f"Application is DOWN! Error: {e}"

# Print and log
print(msg)
log_message(msg)
