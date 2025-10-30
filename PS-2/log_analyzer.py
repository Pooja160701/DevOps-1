#!/usr/bin/env python3
"""log_analyzer.py
Usage: python3 log_analyzer.py --logfile access.log [--top N]
Outputs: total requests, 404 count, top N pages, top N IPs.
"""
import argparse
from collections import Counter
import re

LOG_PATTERN = re.compile(r'(?P<ip>\S+) \S+ \S+ \[(?P<time>[^\]]+)\] "(?P<req>[^"]+)" (?P<status>\d{3}) (?P<size>\S+)')


def analyze(logfile, top_n=10):
    total = 0
    counter_404 = 0
    pages = Counter()
    ips = Counter()

    with open(logfile, 'r', encoding='utf-8', errors='replace') as fh:
        for line in fh:
            m = LOG_PATTERN.search(line)
            if not m:
                continue
            total += 1
            ip = m.group('ip')
            status = m.group('status')
            req = m.group('req')  # e.g. GET /index.html HTTP/1.1
            # extract path
            try:
                method, path, proto = req.split()
            except ValueError:
                path = req
            ips[ip] += 1
            pages[path] += 1
            if status == '404':
                counter_404 += 1

    print(f"Total requests: {total}")
    print(f"404 responses: {counter_404}")
    print('\nTop pages:')
    for p, c in pages.most_common(top_n):
        print(f"{p:60} {c}")
    print('\nTop client IPs:')
    for ip, c in ips.most_common(top_n):
        print(f"{ip:20} {c}")


if __name__ == '__main__':
    ap = argparse.ArgumentParser()
    ap.add_argument('--logfile', '-l', required=True)
    ap.add_argument('--top', '-t', type=int, default=10)
    args = ap.parse_args()
    analyze(args.logfile, args.top)