#!/bin/bash

DATA="$HOME/.azrathix_data"
LOG_FILE="$HOME/.azrathix_log"

# ১. টাইপিং ইফেক্ট ফাংশন
type_effect() {
    for ((i=0; i<${#1}; i++)); do
        echo -n "${1:$i:1}"
        sleep 0.02
    done
    echo
}

# ২. লোডিং অ্যানিমেশন
loading() {
    for i in 10 30 60 90 100
    do
        clear
        echo -e "\e[1;32m[+] Loading Azrathix Modules... $i%\e[0m"
        sleep 0.1
    done
}

# ৩. আরজিবি ব্যানার (অ্যানিমেটেড)
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
        sleep 0.05
    done
}

# ৪. রেজিস্ট্রেশন (পাসওয়ার্ড এনক্রিপশনসহ)
register() {
    banner
    type_effect "🔐 Create Your Secure Azrathix Account"
    read -p "Set Username: " u
    read -sp "Set Password: " p
    echo
    
    # পাসওয়ার্ড এনক্রিপ্ট করা (Base64)
    p_enc=$(echo -n "$p" | base64)
    echo "$u:$p_enc" > "$DATA"
    
    type_effect "✔ Account Created Successfully!"
    sleep 1
}

# ৫. লগইন সিস্টেম
login() {
    banner
    type_effect "🔒 Restricted Access - Please Login"
    read -p "Username: " u
    read -sp "Password: " p
    echo

    # ডাটা ফাইল থেকে পাসওয়ার্ড চেক
    stored_cred=$(cat "$DATA" 2>/dev/null)
    p_enc=$(echo -n "$p" | base64)
    
    if [[ "$stored_cred" == "$u:$p_enc" ]]; then
        type_effect "✔ Access Granted! Welcome back, $u."
        echo "Login Success: $(date)" >> "$LOG_FILE"
        # mpv $HOME/azrathix-tool/sounds/login.mp3 >/dev/null 2>&1 & # সাউন্ড থাকলে আনকমেন্ট করুন
        sleep 1
        loading
        dashboard
    else
        type_effect "❌ Invalid Username or Password!"
        sleep 1
        login
    fi
}

# ৬. সিস্টেম ইনফো ফাংশন (নতুন ফিচার)
show_info() {
    clear
    banner
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
    echo -e "\e[1;36m       SYSTEM INFORMATION         \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
    echo -e "👤 User: $(whoami)"
    echo -e "🖥️ Host: $(hostname)"
    echo -e "💿 OS: $(uname -o)"
    echo -e "⏳ Uptime: $(uptime -p)"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
    read -p "Press [Enter] to go back..."
}

# ৭. মেইন ড্যাশবোর্ড
dashboard() {
    while true
    do
        banner
        echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"
        type_effect "Welcome to Azrathix OS 🚀"
        echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"

        echo -e "\e[32m[1]\e[0m Launch Tool"
        echo -e "\e[32m[2]\e[0m System Information"
        echo -e "\e[32m[3]\e[0m Check Login Logs"
        echo -e "\e[33m[4]\e[0m About"
        echo -e "\e[31m[5]\e[0m Secure Logout"

        echo ""
        read -p "Azrathix@Terminal ➤ " ch

        case $ch in
            1) 
                type_effect "🚀 Starting main modules..."
                sleep 1 ;;
            2) show_info ;;
            3) 
                clear
                type_effect "📜 Recent Login Activities:"
                cat "$LOG_FILE" 2>/dev/null || echo "No logs found."
                read -p "Press Enter..." ;;
            4)
                type_effect "Azrathix Tool v2.0 - Developed for Security & Fun 🔥"
                sleep 2 ;;
            5) 
                type_effect "Logging out safely..."
                exit ;;
            *) 
                type_effect "⚠️ Invalid selection!"; sleep 1 ;;
        esac
    done
}

# স্ক্রিপ্ট শুরু
if [ ! -f "$DATA" ]; then
    register
fi

login
