#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="/opt/devops-project/logs"
LOG_FILE="$LOG_DIR/setup_versions.log"

sudo mkdir -p "$LOG_DIR"

echo "[1/3] Update OS..." | tee "$LOG_FILE"
sudo apt-get update -y | tee -a "$LOG_FILE"
sudo apt-get upgrade -y | tee -a "$LOG_FILE"

echo "[2/3] Install Java 17, Git, Curl, Unzip..." | tee -a "$LOG_FILE"
sudo apt-get install -y openjdk-17-jdk git curl unzip | tee -a "$LOG_FILE"

echo "[3/3] Verify versions..." | tee -a "$LOG_FILE"
java -version 2>&1 | tee -a "$LOG_FILE"
git --version 2>&1 | tee -a "$LOG_FILE"

# Gradle version via wrapper (recommended)
if [ -f /opt/devops-project/app/todo-app/todo-app/gradlew ]; then
  cd /opt/devops-project/app/todo-app/todo-app
  ./gradlew -v 2>&1 | tee -a "$LOG_FILE"
fi

echo "DONE. Log saved to: $LOG_FILE" | tee -a "$LOG_FILE"
