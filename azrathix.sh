#!/bin/bash

DATA="$HOME/.azrathix_data"

# Typing Effect
type() {
for ((i=0; i<${#1}; i++)); do
echo -n "${1:$i:1}"
sleep 0.01
done
echo
}

# Loading Animation
loading() {
for i in 10 30 50 70 90 100
do
clear
echo -e "\e[1;32mLoading... $i%\e[0m"
sleep 0.1
done
}

# RGB Banner
banner() {
colors=(31 32 33 34 35 36)

for c in "${colors[@]}"; do
clear
echo -e "\e[1;${c}m

   █████╗ ███████╗██████╗  █████╗ ████████╗██╗  ██╗
  ██╔══██╗╚══███╔╝██╔══██╗██╔══██╗╚══██╔══╝██║  ██║
  ███████║  ███╔╝ ██████╔╝███████║   ██║   ███████║
  ██╔══██║ ███╔╝  ██╔══██╗██╔══██║   ██║   ██╔══██║
  ██║  ██║███████╗██║  ██║██║  ██║   ██║   ██║  ██║
  ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝

\e[0m"
sleep 0.08
done
}

# Register
register() {
banner
type "Create Your Azrathix Account 🔐"
read -p "Username: " u
read -sp "Password: " p
echo

echo "$u:$p" > $DATA
type "✔ Account Created!"
sleep 1
}

# Login
login() {
banner
type "🔒 Login Required"

read -p "Username: " u
read -sp "Password: " p
echo

if grep -q "$u:$p" $DATA 2>/dev/null; then
type "✔ Access Granted"
mpv $HOME/azrathix-tool/sounds/login.mp3 >/dev/null 2>&1 &
sleep 1
loading
dashboard
else
type "❌ Wrong Credentials"
sleep 1
login
fi
}

# Dashboard
dashboard() {
while true
do
banner
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
type "Welcome to Azrathix System 😎"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"

echo -e "\e[32m[1]\e[0m Start Tool"
echo -e "\e[33m[2]\e[0m About"
echo -e "\e[31m[3]\e[0m Exit"

echo ""
read -p "Choose Option ➤ " ch

case $ch in
1) 
    loading
    type "🚀 Tool Running..."
    sleep 1
    ;;
2)
    type "Azrathix Tool - Ultimate Hacker UI 🔥"
    sleep 2
    ;;
3) exit ;;
*) type "Invalid Option"; sleep 1 ;;
esac
done
}

# Start
if [ ! -f "$DATA" ]; then
register
fi

login
