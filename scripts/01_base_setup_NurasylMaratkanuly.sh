#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="/opt/devops-project/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/versions_$(date +%Y%m%d_%H%M%S).log"

{
  echo "=== Date ==="
  date
  echo

  echo "=== OS ==="
  uname -a
  lsb_release -a 2>&1 || cat /etc/os-release
  echo

  echo "=== Update packages ==="
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install -y git curl ca-certificates unzip
  echo

  echo "=== Java 17 ==="
  sudo apt-get install -y openjdk-17-jdk
  java -version 2>&1
  echo

  echo "=== Gradle ==="
  sudo apt-get install -y gradle
  gradle -v 2>&1
  echo

  echo "=== Git ==="
  git --version 2>&1
  echo
} | tee "$LOG_FILE"

echo "Log saved to: $LOG_FILE"
