## Problem Statement 2 — DevOps Automation Scripts

### 🧩 1. System Health Monitor

**Description:**
Monitors CPU, memory, disk, and process usage. Logs alerts if thresholds are exceeded.

**Commands:**

```bash
chmod +x system_health_monitor.sh
bash system_health_monitor.sh
```

---

### 💾 2. Automated Backup Solution

**Description:**
Automates backup of local directories and logs each backup operation.

**Commands:**

```bash
mkdir -p ~/DevOps-Project-1/PS-2/source_data
mkdir -p ~/DevOps-Project-1/PS-2/backup_data

echo "Backup test file" > ~/DevOps-Project-1/PS-2/source_data/test.txt

bash automated_backup.sh
cat ~/DevOps-Project-1/PS-2/backup.log
```

---

### 📊 3. Log File Analyzer

**Commands:**

```bash
echo '192.168.1.10 - - [30/Oct/2025:10:20:00 +0000] "GET /index.html HTTP/1.1" 200 1024' > sample_access.log
echo '192.168.1.20 - - [30/Oct/2025:10:20:05 +0000] "GET /about.html HTTP/1.1" 200 2048' >> sample_access.log
echo '192.168.1.10 - - [30/Oct/2025:10:20:10 +0000] "GET /contact.html HTTP/1.1" 404 512' >> sample_access.log
echo '192.168.1.30 - - [30/Oct/2025:10:20:15 +0000] "GET /index.html HTTP/1.1" 200 1024' >> sample_access.log

python log_analyzer.py --logfile sample_access.log
```

---

### 🌐 4. Application Health Checker

**Description:**
Checks whether a web application is up or down by verifying HTTP status codes and logs results.

**Commands:**

```bash
python app_health_checker.py --url https://www.google.com
python app_health_checker.py --url https://thiswebsitedoesnotexist12345.com
```
