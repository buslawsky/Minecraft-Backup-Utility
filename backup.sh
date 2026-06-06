#!/bin/bash

# ==============================================================================
# 🛡️ Advanced Minecraft Server Backup Utility (.7z)
# Author: buslawsky
# License: MIT
# ==============================================================================

# --- CONFIGURATION ---
KEEP_DAYS=7
BACKUP_DIR="minecraft_backups"
DATE_FORMAT=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="backup_${DATE_FORMAT}.7z"

# --- AUTOMATIC DIRECTORY DETECTION ---
SERVER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SERVER_DIR" || exit 1

echo "=================================================="
echo "🚀 Starting Minecraft Server Backup..."
echo "📂 Server directory: $SERVER_DIR"
echo "=================================================="

# --- CHECK FOR 7-ZIP INSTALLATION ---
if ! command -v 7z &> /dev/null; then
    echo "❌ Error: 7-Zip (p7zip-full) is not installed."
    echo "💡 Run: sudo apt update && sudo apt install p7zip-full -y"
    exit 1
fi

# --- CREATE BACKUP DIRECTORY IF IT DOES NOT EXIST ---
if [ ! -d "$BACKUP_DIR" ]; then
    echo "📁 Creating backup directory: $BACKUP_DIR..."
    mkdir -p "$BACKUP_DIR"
fi

# --- COMPRESSION PROCESS (WITH EXCLUSION) ---
echo "📦 Compressing server files into 7-Zip archive..."
echo "⏳ Please wait, this might take a while depending on world size..."

# -mx=5: Balanced compression level (Good ratio, optimized CPU usage)
# -xr!...: Excludes the backup folder itself to prevent infinite loops
7z a -mx=5 "${BACKUP_DIR}/${BACKUP_FILE}" . "-xr!${BACKUP_DIR}" > /dev/null

if [ $? -eq 0 ]; then
    echo "✅ Backup created successfully: ${BACKUP_DIR}/${BACKUP_FILE}"
else
    echo "❌ Error: Compression failed!"
    exit 1
fi

# --- AUTOMATED RETENTION POLICY (CLEANUP) ---
echo "🧹 Checking for old backups (Older than $KEEP_DAYS days)..."
find "$BACKUP_DIR" -name "backup_*.7z" -type f -mtime +$KEEP_DAYS -exec rm -f {} \;

echo "✨ Backup process finished smoothly!"
echo "=================================================="
