#!/bin/bash
set -e

VNC_PASSWORD=${VNC_PASSWORD:-secret}
DISPLAY_RESOLUTION=${DISPLAY_RESOLUTION:-1280x960x24}

echo "[INFO] Starting virtual desktop..."
echo "[INFO] VNC password: $VNC_PASSWORD"
echo "[INFO] Resolution: $DISPLAY_RESOLUTION"

rm -f /tmp/.X0-lock

/usr/bin/Xvfb :0 -screen 0 "$DISPLAY_RESOLUTION" -nolisten unix -ac +extension GLX +extension RENDER &
export DISPLAY=:0

mkdir -p /root/wxbot/.vnc/
touch /root/wxbot/.vnc/passwd
x11vnc -storepasswd "$VNC_PASSWORD" /root/wxbot/.vnc/passwd

x11vnc -forever -display :0 -rfbauth /root/wxbot/.vnc/passwd -shared &

/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 6080 &

if [ ! -d "$HOME/.config/fcitx5" ]; then
  echo "[INFO] No fcitx5 config found. Running fcitx5 --configtool..."
  fcitx5-configtool || true
else
  echo "[INFO] fcitx5 config already exists. Skipping configtool."
fi

echo "[INFO] Entering wechat monitoring loop..."
while true; do
  echo "[INFO] Launching WeChat..."
  wechat &
  WECHAT_PID=$!

  wait "$WECHAT_PID"
  echo "[WARN] WeChat exited. Restarting in 5 seconds..."
  sleep 5
done
