#Startup Setup

cat > /etc/rc.local << "EOF"
# Put your custom commands here that should be executed once
# the system init finished. By default this file does nothing.

#Downloading -1

sh -c 'sleep 1; while true; do wget -qO /dev/null "https://cachefly.cachefly.net/100mb.test?$RANDOM"; done' &

#Downloading -2

sh -c 'sleep 2; while true; do wget -qO /dev/null "https://cachefly.cachefly.net/100mb.test?$RANDOM"; done' &

#Downloading -3

sh -c 'sleep 3; while true; do wget -qO /dev/null "https://cachefly.cachefly.net/100mb.test?$RANDOM"; done' &

# Search & Tech Giants
ping -i 1 8.8.8.8 >/dev/null 2>&1 &
ping -i 1 1.1.1.1 >/dev/null 2>&1 &
ping -i 1 microsoft.com >/dev/null 2>&1 &
ping -i 1 apple.com >/dev/null 2>&1 &
ping -i 1 yahoo.com >/dev/null 2>&1 &
ping -i 1 bing.com >/dev/null 2>&1 &

# Social Media & Communication
ping -i 1 facebook.com >/dev/null 2>&1 &
ping -i 1 instagram.com >/dev/null 2>&1 &
ping -i 1 x.com >/dev/null 2>&1 &
ping -i 1 linkedin.com >/dev/null 2>&1 &
ping -i 1 whatsapp.com >/dev/null 2>&1 &
ping -i 1 discord.com >/dev/null 2>&1 &

# Video Streaming & Entertainment
ping -i 1 youtube.com >/dev/null 2>&1 &
ping -i 1 netflix.com >/dev/null 2>&1 &
ping -i 1 primevideo.com >/dev/null 2>&1 &
ping -i 1 twitch.tv >/dev/null 2>&1 &
ping -i 1 spotify.com >/dev/null 2>&1 &

# E-commerce & Shopping
ping -i 1 amazon.com >/dev/null 2>&1 &
ping -i 1 aliexpress.com >/dev/null 2>&1 &
ping -i 1 ebay.com >/dev/null 2>&1 &
ping -i 1 alibaba.com >/dev/null 2>&1 &

# Cloud, Development & Infrastructure
ping -i 1 github.com >/dev/null 2>&1 &
ping -i 1 aws.amazon.com >/dev/null 2>&1 &
ping -i 1 cloudflare.com >/dev/null 2>&1 &
ping -i 1 azure.microsoft.com >/dev/null 2>&1 &
ping -i 1 digitalocean.com >/dev/null 2>&1 &

# Gaming & Others
ping -i 1 steampowered.com >/dev/null 2>&1 &
ping -i 1 epicgames.com >/dev/null 2>&1 &
ping -i 1 wikipedia.org >/dev/null 2>&1 &
ping -i 1 reddit.com >/dev/null 2>&1 &

exit 0
EOF

chmod +x /etc/rc.local

#!/bin/sh

# Function: Strictly control each step
run_step() {
    local step_name="$1"
    local command="$2"

    while true; do
        echo "------------------------------------------------"
        echo "👉 Step: $step_name"
        echo -n "▶ Press 'y' and Enter to start (or 'n' to cancel): "
        read user_choice

        # Default to 'y' if Enter is pressed
        if [ -z "$user_choice" ] || [ "$user_choice" = "y" ]; then
            echo "⏳ Running..."
            
            # Execute the command
            eval "$command"
            local status=$?
            
            # Check if the command was successful
            if [ $status -eq 0 ]; then
                echo "✅ Success: $step_name completed!"
                break # Exit loop and move to the next step if successful
            else
                echo "⚠️ Error! This step failed."
                echo "🛑 By rule, you cannot proceed to the next step until this is successful."
                echo -n "🔄 Press 'y' to retry after fixing the issue (or 'n' to abort installation): "
                read retry_choice
                
                if [ "$retry_choice" = "n" ]; then
                    echo "❌ Installation aborted."
                    exit 1
                fi
                echo "🔄 Retrying..."
            fi
        elif [ "$user_choice" = "n" ]; then
            echo "❌ Installation cancelled."
            exit 1
        else
            echo "Please type 'y' or 'n'."
        fi
    done
}

clear
echo "🚀 Starting BDIX Strict Installer..."

# Step 1: Update
run_step "Updating package list (opkg update)" \
"opkg update"

# Step 2: Install packages
run_step "Installing required packages" \
"opkg install iptables iptables-mod-nat-extra redsocks 6in4 ipv6helper irqbalance luci-app-ttyd shellsync"

# Step 3: Setup configuration safely (prevents false errors on retry)
run_step "Backing up old configuration and setting up new files" \
"service redsocks stop 2>/dev/null || true ; [ -f /etc/redsocks.conf ] && mv /etc/redsocks.conf /etc/redsocks.conf.bkp ; wget -O /etc/bdix.conf https://github.com/IXWRT/BNET/raw/main/bdix.conf && [ -f /etc/init.d/redsocks ] && mv /etc/init.d/redsocks /etc/init.d/redsocks.bkp ; wget -O /etc/init.d/bdix https://github.com/IXWRT/BNET/raw/main/bdix && chmod +x /etc/init.d/bdix"

# Step 4: Enable service
run_step "Enabling BDIX auto boot-start" \
"service bdix enable"

# Step 5: Start service
run_step "Starting BDIX service" \
"service bdix start"

# Step 6: Install theme
run_step "Installing LuCI theme Aurora" \
"wget -O /tmp/aurora.ipk 'https://github.com/eamonxg/luci-theme-aurora/releases/download/v0.11.0/luci-theme-aurora_0.11.0-r20260208_all.ipk' && opkg install /tmp/aurora.ipk && rm /tmp/aurora.ipk"

echo "------------------------------------------------"
echo "🎉 Congratulations! All steps completed successfully and BDIX is now running."

#Wifi Config

cat > /etc/config/wireless << "EOF"

config wifi-device 'radio0'
        option type 'mac80211'
        option path '1e140000.pcie/pci0000:00/0000:00:01.0/0000:02:00.0'
        option channel 'auto'
        option band '2g'
        option htmode 'HT40'
        option disabled '0'
        option cell_density '3'
        option mu_beamformer '1'
        option noscan '1'
        option vendor_vht '1'

config wifi-iface 'default_radio0'
        option device 'radio0'
        option network 'lan'
        option mode 'ap'
        option ssid 'Xiaomi 2.4Ghz'
        option encryption 'sae'
        option macfilter 'allow'
        list maclist 'AC:12:03:5D:78:39'
        option hidden '1'
        option key '           '

config wifi-device 'radio1'
        option type 'mac80211'
        option path '1e140000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0'
        option channel 'auto'
        option band '5g'
        option htmode 'VHT80'
        option disabled '0'
        option cell_density '3'
        option mu_beamformer '1'

config wifi-iface 'default_radio1'
        option device 'radio1'
        option network 'lan'
        option mode 'ap'
        option ssid 'Xiaomi 5Ghz'
        option encryption 'sae'
        option macfilter 'allow'
        list maclist 'AC:12:03:5D:78:39'
        option hidden '1'
        option key '           '

EOF
wifi reload
reboot
