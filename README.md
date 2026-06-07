# 🛡️ Advanced Minecraft Server Backup Utility (.7z)

A professional, zero-configuration Bash script designed for production Minecraft servers running on **Debian / Ubuntu** environments. It automates server backups using the ultra-efficient **7-Zip** compression algorithm, features automatic retention management, and prevents recursive backup loops.

---

## 🚀 Key Features

* **Zero-Config Deployment:** Automatically detects the server directory path. Just drop it in and run.
* **High-Ratio Compression:** Utilizes `7-Zip` (`.7z`) instead of standard `tar.gz`, saving up to 50% more disk space on worlds and core files.
* **Smart Exclusion:** Automatically excludes the backup directory from the compression process to prevent recursive loop storage issues.
* **Automated Retention Policy:** Self-cleaning mechanism that automatically purges backups older than a specified number of days (Default: 7).
* **Silent & Resource-Optimized:** Tuned with optimal compression levels (`-mx=5`) to prevent CPU spikes on low-end VPS instances.

---

## 📊 Performance Comparison

| Compression Format | Space Saved | CPU Impact | Recommendation |
| :--- | :---: | :---: | :--- |
| **Tarball (`.tar.gz`)** | Standard (~40%) | Low | Outdated |
| **Zip (`.zip`)** | Poor (~30%) | Very Low | Not recommended for worlds |
| **7-Zip (`.7z`)** 🏆 | **Excellent (~70%)** | **Balanced** | **Best for Production** |

---

## 🛠️ Prerequisites

Before executing the script, ensure that the `p7zip-full` package is installed on your Debian/Ubuntu machine:

```bash
sudo apt update && sudo apt install p7zip-full -y

📦 Installation & Usage

    Download the backup.sh script and place it directly into your root Minecraft server directory (where server.jar is located).

    Grant execution permissions via your terminal:

chmod +x backup.sh

3. **Run the script manually** to test:

./backup.sh

A new folder named minecraft_backups will be created inside your server directory, containing timestamped archives like backup_20260606_220000.7z.
⏰ Automation via Cron

To run this backup automatically every day at 04:00 AM, add a cron job:

    Open the crontab editor:

crontab -e

2. Append the following line at the bottom (replace with your actual path):
  
   0 4 * * * /home/debian/minecraft_server/backup.sh >/dev/null 2>&1

⚙️ Configuration Variables

If you want to tweak the settings, open backup.sh with your preferred editor (nano/vim) and modify these lines:

    KEEP_DAYS=7 — Change the number of days to keep old backups before auto-deletion.

    -mx=5 — Compression level (1 = fastest/largest, 9 = slowest/smallest). 5 is optimized for modern multi-core servers.

📄 License & Services

This project is open-source under the MIT License.

💡 Need Custom Infrastructure Help?

I offer premium, anonymous freelancing services for Minecraft networks and Web3 projects (payable in crypto/USDT/LTC):

    Linux VPS Server Hardening & Security Setup (Debian/Ubuntu)

    Pterodactyl Panel Deployments

    Custom Spigot/Paper Plugin Configurations & Skript Development

    Performance & Java Flags Optimization (Aikar's Flags)

Contact me via Discord/Telegram or open an issue.


---
