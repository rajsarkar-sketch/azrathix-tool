#!/bin/bash

echo "Removing Azrathix Tool..."

# Remove from bashrc
sed -i '/azrathix-tool/d' ~/.bashrc

# Delete files
rm -rf $HOME/azrathix-tool
rm -f $HOME/.azrathix_data

echo "Uninstalled Successfully!"
