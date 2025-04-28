#!/bin/bash

set -e

echo "[INFO] Atualizando pacotes..."
apt-get update

echo "[INFO] Instalando dependências básicas..."
apt-get install -y ca-certificates curl gnupg lsb-release sudo

echo "[INFO] Instalando Docker..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[INFO] Instalando Docker Compose v2..."
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "[INFO] Subindo containers com Docker Compose..."
cd /vagrant
docker-compose up -d

echo "[INFO] Configurando Docker Compose para iniciar com o sistema..."
cat <<EOF > /etc/systemd/system/docker-compose-app.service
[Unit]
Description=Docker Compose GLPI
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/vagrant
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable docker-compose-app
systemctl start docker-compose-app

echo "[INFO] Finalizado!"
