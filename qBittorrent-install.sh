#!/bin/bash

TYPE=$(uname -m)
if ! command -v wget &>/dev/null; then
    echo "请先安装 wget"
    exit 1
fi
cd ~
wget -qO /usr/local/bin/qbittorrent-nox "https://github.com/userdocs/qbittorrent-nox-static/releases/download/release-4.5.4_v2.0.9/$TYPE-qbittorrent-nox"
chmod +x /usr/local/bin/qbittorrent-nox

CONF_PATH="/usr/local/etc"
read -rp "请输入配置文件保存目录(回车默认${CONF_PATH}): " input
if [[ -n "$input" ]]; then
    CONF_PATH="$input"
fi

echo "[Unit]
    Description=qBittorrent Service
    After=network.target nss-lookup.target
    
    [Service]
    UMask=000
    ExecStart=/usr/local/bin/qbittorrent-nox --profile="${CONF_PATH}"
    WorkingDirectory=/usr/local/bin/
    Restart=on-abnormal
    
    [Install]
    WantedBy=multi-user.target" > /etc/systemd/system/qbittorrent-nox.service

systemctl daemon-reload
systemctl start qbittorrent-nox
systemctl enable qbittorrent-nox
systemctl status qbittorrent-nox

echo "--------------------------------"
echo "Open ip:8080 in your browser"
echo "user:admin"
echo "passwd:adminadmin"
echo "停止后再编辑配置文件 ${CONF_PATH}/qBittorrent/config/qBittorrent.conf"
echo "--------------------------------"
echo "======== qbittorrent-nox ========"
echo "启动 systemctl start qbittorrent-nox"
echo "停止 systemctl stop qbittorrent-nox"
echo "状态 systemctl status qbittorrent-nox"
echo "开机自启 systemctl enable qbittorrent-nox"
echo "禁用自启 systemctl disable qbittorrent-nox"
echo "======== qbittorrent-nox ========"
