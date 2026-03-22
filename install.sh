#!/bin/bash

clear
echo "Installing Azrathix Tool..."

# Create folder
mkdir -p $HOME/azrathix-tool
cd $HOME/azrathix-tool

# Give permission
chmod +x azrathix.sh

# Auto start (safe way)
echo "bash $HOME/azrathix-tool/azrathix.sh" >> ~/.bashrc

echo "Installation Complete!"
echo "Restart Termux"
