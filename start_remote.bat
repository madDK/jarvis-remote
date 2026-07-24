@echo off
title JARVIS Remote Control Launcher (Cloudflare HTTPS)
echo ========================================================
echo   🤖 JARVIS REMOTE CONTROL (ENTERPRISE CLOUDFLARE TUNNEL)
echo ========================================================
echo.
echo 1. Starting JARVIS assistant engine on PC...
start python main.py
echo.
echo 2. Launching Cloudflare HTTPS Tunnel...
"C:\Program Files (x86)\cloudflared\cloudflared.exe" tunnel --url https://127.0.0.1:8000 --no-tls-verify
