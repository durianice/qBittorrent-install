#!/bin/bash

TYPE=$(uname -m)
if ! command -v wget &>/dev/null; then
    echo "请先安装 wget"
    exit 1
fi
wget -qO /usr/local/bin/qbittorrent-nox "https://github.com/userdocs/qbittorrent-nox-static/releases/download/release-4.5.4_v2.0.9/$TYPE-qbittorrent-nox"
chmod +x /usr/local/bin/qbittorrent-nox

echo "[Unit]
    Description=qBittorrent Service
    After=network.target nss-lookup.target
    
    [Service]
    UMask=000
    ExecStart=/usr/local/bin/qbittorrent-nox --profile=/usr/local/etc
    WorkingDirectory=/usr/local/bin/
    Restart=on-abnormal
    
    [Install]
    WantedBy=multi-user.target" > /etc/systemd/system/qbittorrent-nox.service

systemctl daemon-reload
systemctl start qbittorrent-nox
systemctl enable qbittorrent-nox
systemctl status qbittorrent-nox

echo "======== qbittorrent-nox ========"
echo "启动 systemctl start qbittorrent-nox"
echo "停止 systemctl stop qbittorrent-nox"
echo "状态 systemctl status qbittorrent-nox"
echo "开机自启 systemctl enable qbittorrent-nox"
echo "禁用自启 systemctl disable qbittorrent-nox"
echo "======== qbittorrent-nox ========"
