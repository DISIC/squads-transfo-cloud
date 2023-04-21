#!/bin/bash
sudo useradd -m user1
echo "user1:user1" | chpasswd
sudo usermod -aG sudo user1
sudo usermod -aG sudo user1
