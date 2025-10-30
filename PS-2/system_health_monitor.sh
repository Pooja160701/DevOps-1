#!/usr/bin/env bash
# system_health_monitor.sh
# Monitors CPU, memory, disk, and process counts against thresholds in config.cfg

set -euo pipefail
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CONFIG="$SCRIPT_DIR/config.cfg"
LOGFILE="$SCRIPT_DIR/system_health.log"

# Default thresholds (overridden by config.cfg)
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=85
MAX_PROCESSES=400

# Read config if present
if [[ -f "$CONFIG" ]]; then
  # Use simple parsing: key=value lines
  while IFS='=' read -r key value; do
    key=$(echo "$key" | tr -d ' \t\r')
    value=$(echo "$value" | tr -d ' \t\r')
    case "$key" in
      CPU_THRESHOLD) CPU_THRESHOLD=$value ;;
      MEM_THRESHOLD) MEM_THRESHOLD=$value ;;
      DISK_THRESHOLD) DISK_THRESHOLD=$value ;;
      MAX_PROCESSES) MAX_PROCESSES=$value ;;
    esac
  done < <(grep -E '^[A-Za-z_]+=.*' "$CONFIG" || true)
fi

timestamp() { date '+%Y-%m-%d %H:%M:%S'; }
log() { echo "$(timestamp) - $*" | tee -a "$LOGFILE"; }

ALERTS=0

# CPU usage (average of all cores, using top)
CPU_USAGE=$(top -bn1 | grep "%Cpu(s)" | awk -F',' '{print $1}' | awk '{print 100 - $2}')
CPU_USAGE=${CPU_USAGE%%.*}
if (( CPU_USAGE > CPU_THRESHOLD )); then
  log "ALERT: CPU usage ${CPU_USAGE}% > ${CPU_THRESHOLD}%"
  ((ALERTS++))
else
  log "OK: CPU usage ${CPU_USAGE}% <= ${CPU_THRESHOLD}%"
fi

# Memory usage (percentage used)
MEM_USED=$(free | awk '/Mem:/ {printf("%.0f", $3/$2*100)}')
if (( MEM_USED > MEM_THRESHOLD )); then
  log "ALERT: Memory usage ${MEM_USED}% > ${MEM_THRESHOLD}%"
  ((ALERTS++))
else
  log "OK: Memory usage ${MEM_USED}% <= ${MEM_THRESHOLD}%"
fi

# Disk usage (root filesystem)
DISK_USED=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
if (( DISK_USED > DISK_THRESHOLD )); then
  log "ALERT: Disk usage ${DISK_USED}% > ${DISK_THRESHOLD}%"
  ((ALERTS++))
else
  log "OK: Disk usage ${DISK_USED}% <= ${DISK_THRESHOLD}%"
fi

# Process count
PROC_COUNT=$(ps -e --no-headers | wc -l)
if (( PROC_COUNT > MAX_PROCESSES )); then
  log "ALERT: Process count ${PROC_COUNT} > ${MAX_PROCESSES}"
  ((ALERTS++))
else
  log "OK: Process count ${PROC_COUNT} <= ${MAX_PROCESSES}"
fi

# If any alerts, summary
if (( ALERTS > 0 )); then
  log "SUMMARY: ${ALERTS} alert(s) detected"
  exit 2
else
  log "SUMMARY: All checks OK"
  exit 0
fi