#!/usr/bin/env bash
# Install the NVIDIA Container Toolkit so Docker can use the GPU (--gpus all).
# Run with: sudo bash docker/install_nvidia_toolkit.sh
set -euo pipefail

echo "[1/6] keyring dir"
install -d -m 0755 /usr/share/keyrings

echo "[2/6] import NVIDIA GPG key"
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
  | gpg --dearmor --yes -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

echo "[3/6] write apt source (note the required space after 'deb')"
cat > /etc/apt/sources.list.d/nvidia-container-toolkit.list <<'EOF'
deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://nvidia.github.io/libnvidia-container/stable/deb/$(ARCH) /
EOF

echo "[4/6] apt update + install"
apt-get update
apt-get install -y nvidia-container-toolkit

echo "[5/6] register Docker runtime"
nvidia-ctk runtime configure --runtime=docker

echo "[6/6] restart Docker"
systemctl restart docker

echo "DONE: nvidia-container-toolkit installed; Docker GPU runtime configured."
