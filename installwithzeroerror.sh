#Startup Setup

cat > /etc/rc.local << "EOF"
# Put your custom commands here that should be executed once
# the system init finished. By default this file does nothing.

#Downloading -1

#sh -c 'sleep 1; while true; do wget -qO /dev/null "https://cachefly.cachefly.net/100mb.test?$RANDOM"; done' &

#Downloading -2

#sh -c 'sleep 2; while true; do wget -qO /dev/null "https://cachefly.cachefly.net/100mb.test?$RANDOM"; done' &

#Downloading -3

#sh -c 'sleep 3; while true; do wget -qO /dev/null "https://cachefly.cachefly.net/100mb.test?$RANDOM"; done' &

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
"opkg install iptables iptables-mod-nat-extra redsocks 6in4 ipv6helper irqbalance luci-app-ttyd shellsync openvpn-openssl luci-app-openvpn"

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

#Remote Access Setup 

# 1. ডাইনামিক রাউটিং এর জন্য কাস্টম স্ক্রিপ্ট তৈরি করা
mkdir -p /etc/openvpn
cat << 'EOF' > /etc/openvpn/pbr.sh
#!/bin/sh
ip rule add from $ifconfig_local table 200 2>/dev/null
ip route add default dev $dev table 200 2>/dev/null
EOF
chmod +x /etc/openvpn/pbr.sh

# 2. OpenVPN কনফিগারেশন ফাইল তৈরি (অটোমেশন স্ক্রিপ্ট সহ)
cat << 'EOF' > /etc/openvpn/myvpn.conf
client
nobind
dev tun0
key-direction 1
remote-cert-tls server

remote 193.161.193.99 1194 tcp
route-nopull
script-security 2
route-up /etc/openvpn/pbr.sh

<key>
-----BEGIN PRIVATE KEY-----
MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDNgvwyM+0jE2HW
gr6Qv0L63X9VlU4Kd92LGH/8RF21ic3YeFjemX3JWIw2UCPvZfFEXbQMzxl63Lc0
QZ+6yIA980WhWqZ/+LM0OaZ4DGN+sf8x4/uH3S9c3SFMd55glddRVOdB45TBtP3A
kjDNuFJ679eRjsiKzJSYCRa+rlhVhSOWA69pLIivCz1zRgraiVaQw+0jGA3OfUyD
fvs4BkBWy+2ahL1GnJxv+k9Lhw+55/8QPWYupeq4dNHq1tKZTaPZzwHCjA8h6pIS
ZwwlqCEpX3puN+8sxok4p461hjdsLzhrIBs1Bczvo/j6uvo2GdmiIvdIkYAqJ4lP
1KarUnYtAgMBAAECggEACEseq9T6HyX/VwWINLWvOYn6Q0Um9New/lXDBnZo1LRm
tPNoXLVThO5YnDGAPb8+rQxeAX1TESj6kLaMQGCqgjWAzBnpKbVq3/Lqo6IWWszK
mGQTqMA1ktkOqLQUFWA+o/bZ7UgGnwmTivOrWgXz+CeZKrPZJnbKkVcejpvhDzRh
auZosC0SmSFNp5B8otzpWEh1/kQv6j5eT71l3V6osmAotWrsd9yhSob1NGlcwdyj
OEBl56FvCED/wUl8qw3T5gLtuaeTL0fCMcyoy1FoOUBCBzI9nw+leqw5LAw6mjkD
yRBJYvGWEfG81vvY929MRI6eF4oDt+tXkR3hlrHdaQKBgQD755un33HscoHFbPwk
O4DNsZG0QFkO6RakkBToroHKzW66FN995U6GF+RZboJww7enKCIV6gRXMivv0Imt
0PmtD1tS+a1wG/ArvZQn5VVLXE9pN6FSwqxPTtIDDBkci5NLTHVzDVrY3hRrSe5j
ZrSG59eyqw4v+Zh1Zgt+aNXy9QKBgQDQ2ku1TU2j77DcfKfrFp6exve7IFbHGaSl
9L/MhzEo/f4ROY0oErjD7oGTGJ0Iiz1tVVpu7OCfb7pynW+VQUY/c5IHicEKoCeb
DhrHBW2eiieV8tRiWzfqExkNH7IbDSwN1D+CT07mRbQpwIKkYfFd34wVGQOEqMXp
7qFtUOOjWQKBgBN9zVaE/JyuE4qCL1RiYkoINlz7Kaj0sjLTjzqd3h8iHDI70Ts9
lgDcMmgVG/S7wCcn/NMzQ1i34hxxR2XyqI8ShB98gEYPc1r/FUqs/ReSsfZTPqFX
vNt6HtfrhLnntuL5rJDVdLUZIf1XQCHi3Y8eu1rwz2044+oZlkQWuo9NAoGAJomx
YKIECpUHAJhr78A7wraaLchY2uJLdGgGIDpuAs9jW1BQUK2rtFPFSxxGlbYDvrH6
Pu+svx7Bu7Z7SYJC8SBlOMjdexV0WXMv07uXr6J0jYHCWOfWGHYvsDFCDyXOFDsv
AN+bgngoN3ATazu7awP9+EKmWItAAduLo/1CE/kCgYAopt8nhiWZYQApdZ3qVKoU
RxMSe0ZRk+6HY2B2OiUnD/7vjp+8SfK5MmpleUpsLL2MI5Cg2s8QKyXzLJsGETOF
OfM7nRd62iRjCwVN45yVp0cZ5amjgwwy/2waaQxDBQWCVQt4arNGg0WG4jxiU6XK
CXTqtyWqzHe2FKmiH6XQWA==
-----END PRIVATE KEY-----
</key>
<cert>
-----BEGIN CERTIFICATE-----
MIIDVjCCAj6gAwIBAgIRAKCq+cGP2dLzuomoq0JHa5owDQYJKoZIhvcNAQELBQAw
FTETMBEGA1UEAwwKUG9ydG1hcCBDQTAeFw0yNTExMDYxNDA3NDlaFw0zNTExMDQx
NDA3NDlaMBQxEjAQBgNVBAMMCU1pTWVzaC5NaTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAM2C/DIz7SMTYdaCvpC/Qvrdf1WVTgp33YsYf/xEXbWJzdh4
WN6ZfclYjDZQI+9l8URdtAzPGXrctzRBn7rIgD3zRaFapn/4szQ5pngMY36x/zHj
+4fdL1zdIUx3nmCV11FU50HjlMG0/cCSMM24Unrv15GOyIrMlJgJFr6uWFWFI5YD
r2ksiK8LPXNGCtqJVpDD7SMYDc59TIN++zgGQFbL7ZqEvUacnG/6T0uHD7nn/xA9
Zi6l6rh00erW0plNo9nPAcKMDyHqkhJnDCWoISlfem437yzGiTinjrWGN2wvOGsg
GzUFzO+j+Pq6+jYZ2aIi90iRgConiU/UpqtSdi0CAwEAAaOBoTCBnjAJBgNVHRME
AjAAMB0GA1UdDgQWBBSHQuHd1iRxKOtreflT80QPlILKEjBQBgNVHSMESTBHgBRe
xe8fUpdyhukLWbgikvyra38An6EZpBcwFTETMBEGA1UEAwwKUG9ydG1hcCBDQYIU
StIHC8goPcXPzdKkO2ovj9DyTagwEwYDVR0lBAwwCgYIKwYBBQUHAwIwCwYDVR0P
BAQDAgeAMA0GCSqGSIb3DQEBCwUAA4IBAQBk2A2iZREbjVNMCSjkugyh/uOZnvy6
NIiCkt0SzsYE2AK8Xz26S2AePugDKAMmd4R0r+E8XBpIdikurh3v3yu6HO5kIf8r
egsxx1GrTT73zgGwDH0UvQY+pM8A8MwDMrWJMnSyaQuAEM6YLE/lAyLAyup8koVA
OFQtnvCCPsGZ2y9Z0ySYp35RJ/GNvozKDuPc+HDM6TxrQath+qGZeqyqEZG7Ui2N
ijrOIvTvwsUetEGIVtMQIqKEh4hCexC7y8gP1s2EA4Hl6kZacBwVvABgFTSoHYPE
a6F1vhcce/6Q+m5wlbT8eCbI7f61GQri0SrndhJ/lJ5k0uAgj1NyWjLi
-----END CERTIFICATE-----
</cert>
<ca>
-----BEGIN CERTIFICATE-----
MIIDSDCCAjCgAwIBAgIUStIHC8goPcXPzdKkO2ovj9DyTagwDQYJKoZIhvcNAQEL
BQAwFTETMBEGA1UEAwwKUG9ydG1hcCBDQTAeFw0yNTEwMzAwMTE3NDFaFw0zNTEw
MjgwMTE3NDFaMBUxEzARBgNVBAMMClBvcnRtYXAgQ0EwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCnSBLhf3eDHOc2a6dl4YcdcIsFLNmLYdZo2J1qBp/N
MoZrpFWY1qf0VpphArqkaD4UY+8uOPyfZ+3yxhPOVZzGsYSYykpkIWWGi7HwBe6x
PpjLTT3XvBRSz6KHGUcXldeQxJKSmS9blq1+JcI3QRgVUL+Q3/HrvrAyUVTmzMip
aKe1m2L6h78dfLs8BOjxHk29sJiQHstNrMmBJehy4VdltzNGGAraFQLYaqIUWxyx
2AZcJcgHOYzzf+T8KR8ig69PbXgFC50dZH6uiPv0f2PEcXSQ4o5bY2e4kurFEuAN
KJTa/Y3crJ897CxpHdplgJcEomML1y3bxE/QtNNF2eMNAgMBAAGjgY8wgYwwHQYD
VR0OBBYEFF7F7x9Sl3KG6QtZuCKS/KtrfwCfMFAGA1UdIwRJMEeAFF7F7x9Sl3KG
6QtZuCKS/KtrfwCfoRmkFzAVMRMwEQYDVQQDDApQb3J0bWFwIENBghRK0gcLyCg9
xc/N0qQ7ai+P0PJNqDAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIBBjANBgkqhkiG
9w0BAQsFAAOCAQEAHRHTX724CjGcfVcE/AscysAYXlVXmc48vKx9kqJiqyG7+mBt
gW5aIIqHIDGCyIJD47GRH6E0Rb19opGru53KsHUhiMXeSCmH+N/zew35l3R3cyLZ
fAHFlqeeLve5g7ozPWgpRoCISVoP8Us2jggwheOYNtTU4C9lVr2ojejmIz2rq03p
p6rHY0AfwzZRfN5CQkXAUauVvwo5QupmUQ1z8aBnW9WZLCLu114wpqSqMaTzkD89
aenMJoWMRnJhW1yt0aL3c/0b+EzfaRePE+i0SpjIYdXPrcRXLayJZygzBgl2nUaa
Yn4yh0mVdscdM7FLTCq8PWQDCmr6dgsRzdMLPA==
-----END CERTIFICATE-----
</ca>
<tls-auth>
-----BEGIN OpenVPN Static key V1-----
42bb453ee0df769b134e57435c88a745
927d7fd254987077bdf822567410ed73
f816335742f5737b0ad1e290ebe4e669
1a8edad3f23aff0c4872172f1e3c30d2
025cddbfd2dfdcecb3ef2f1f4e531c60
1e9c48e1abe96c46c80eaa5f121a72b5
e7b194a6a0abc06fbc736abc41122f5d
aa0c7ddcfc80455983ac7e6cb005d0c7
7ef5ed9c20cebe4481a733a5b4e63ba8
74a0710bcd0b732d5b79ef6e2032c0c2
6e1cbe01873367524a28d582901ceed1
241fe087a8e84467c9c790c7af719622
413fcc77b130629258db8a8e6678f53c
7cd213dc82e5b613ca310642cfbb6cb5
63111511e467f45417d9950035827d30
43b13e9e01f0c42481edb1fe1808806b
-----END OpenVPN Static key V1-----
</tls-auth>
key-direction 1
cipher AES-128-CBC
EOF

# 3. নেটওয়ার্ক এবং ফায়ারওয়াল ইন্টারফেস তৈরি (ফ্রেশ করে)
uci set network.vpn_remote=interface
uci set network.vpn_remote.proto='none'
uci set network.vpn_remote.device='tun0'
uci commit network

uci add firewall zone
uci set firewall.@zone[-1].name='vpn_zone'
uci set firewall.@zone[-1].input='ACCEPT'
uci set firewall.@zone[-1].output='ACCEPT'
uci set firewall.@zone[-1].forward='REJECT'
uci set firewall.@zone[-1].network='vpn_remote'

uci add firewall rule
uci set firewall.@rule[-1].name='vpn_http_rule'
uci set firewall.@rule[-1].target='ACCEPT'
uci set firewall.@rule[-1].src='vpn_zone'
uci set firewall.@rule[-1].dest_port='80'
uci commit firewall

# 4. uHTTPd সিকিউরিটি ফিল্টার বন্ধ করা
uci set uhttpd.main.rfc1918_filter='0'
uci commit uhttpd

# 5. OpenVPN এনাবেল করা
uci set openvpn.myvpn=openvpn
uci set openvpn.myvpn.enabled='1'
uci set openvpn.myvpn.config='/etc/openvpn/myvpn.conf'
uci commit openvpn

# 6. সার্ভিসগুলো রিস্টার্ট করা
/etc/init.d/network restart
/etc/init.d/firewall restart
/etc/init.d/uhttpd restart
/etc/init.d/openvpn enable
/etc/init.d/openvpn restart

echo "Setup Completed Successfully! Automation is Active."

#PBR Delete

# 1. Delete (Ignore Local Requests,Plex/Emby)
while uci show pbr | grep -qE "name='(Ignore Local Requests|Plex/Emby Local Server|Plex/Emby Remote Servers)'"; do
    rule=$(uci show pbr | grep -E "name='(Ignore Local Requests|Plex/Emby Local Server|Plex/Emby Remote Servers)'" | head -n 1 | awk -F. '{print $2}' | awk -F= '{print $1}')
    uci -q delete pbr."$rule"
done

# 2.Delete 'pbr.user.netflix' 
while uci show pbr | grep -q "/usr/share/pbr/pbr.user.netflix"; do
    inc=$(uci show pbr | grep "/usr/share/pbr/pbr.user.netflix" | head -n 1 | awk -F. '{print $2}' | awk -F= '{print $1}')
    uci -q delete pbr."$inc"
done

# 3. Save & Restart
uci commit pbr
/etc/init.d/pbr restart

#

# ---------------------------------------------------------
# ১. Set (Metric) 
# ---------------------------------------------------------
uci set network.wan.metric='0'
uci set network.wan6.metric='0'
uci set network.lan.metric='0'
uci set network.Wireguard.metric='1'

# ---------------------------------------------------------
# ২. Wireguard Setup
# ---------------------------------------------------------
uci set network.Wireguard=interface
uci set network.Wireguard.proto='wireguard'
uci set network.Wireguard.private_key='aNA/MbdZvGp7hghIkOW5tz50gTzRJbWaC/XzwY6aDmg='
uci add_list network.Wireguard.addresses='10.0.20.10/32'
uci add_list network.Wireguard.dns='8.8.8.8'
uci add_list network.Wireguard.dns='1.1.1.1'
uci set network.Wireguard.force_link='1'

# ---------------------------------------------------------
# ৩. Wireguard (Peer) Setup
# ---------------------------------------------------------
uci set network.WireguardPeer=wireguard_Wireguard
uci set network.WireguardPeer.public_key='EuyNyUe8zbSm8dh2oPnBuoox2Ugqa2OshOpCllCzGR0='
uci set network.WireguardPeer.endpoint_host='182.160.101.172'
uci set network.WireguardPeer.endpoint_port='13231'
uci set network.WireguardPeer.persistent_keepalive='1'
#   Wireguard Traffic
uci set network.WireguardPeer.route_allowed_ips='0'
uci add_list network.WireguardPeer.allowed_ips='0.0.0.0/0'
uci set network.WireguardPeer.description='Wireguard'

# ---------------------------------------------------------
# ৪.  (Firewall Zone) 
# ---------------------------------------------------------
uci set firewall.Wireguard=zone
uci set firewall.Wireguard.name='Wireguard'
uci set firewall.Wireguard.input='REJECT'
uci set firewall.Wireguard.output='ACCEPT'
uci set firewall.Wireguard.forward='REJECT'
uci set firewall.Wireguard.masq='1'
uci set firewall.Wireguard.mtu_fix='1'
uci add_list firewall.Wireguard.network='Wireguard'

# LAN to Wireguard-Forward
uci set firewall.wg_fwd=forwarding
uci set firewall.wg_fwd.src='lan'
uci set firewall.wg_fwd.dest='Wireguard'

# ---------------------------------------------------------
# ৫. PBR (Policy-Based Routing) Setup
# ---------------------------------------------------------
uci set pbr.config.enabled='1'
uci set pbr.config.ipv6_enabled='1'

uci set pbr.wg_routes=policy
uci set pbr.wg_routes.name='Wireguard Custom Routes'
uci set pbr.wg_routes.interface='Wireguard'
uci set pbr.wg_routes.dest_addr='speedtest.net apkpure.com downsub.com 104.26.12.205 104.26.13.205 172.67.74.152 173.245.48.0/20 103.21.244.0/22 103.22.200.0/22 103.31.4.0/22 141.101.64.0/18 108.162.192.0/18 190.93.240.0/20 188.114.96.0/20 197.234.240.0/22 198.41.128.0/17 162.158.0.0/15 104.16.0.0/13 104.24.0.0/14 172.64.0.0/13 131.0.72.0/22'

# ---------------------------------------------------------
# ৬. Save & Apply
# ---------------------------------------------------------
uci commit network
uci commit firewall
uci commit pbr

/etc/init.d/network restart
/etc/init.d/firewall restart
/etc/init.d/pbr restart

#Admin Password & Hostname Set

#echo -e "IXWRT\nIXWRT" | passwd root
uci commit system
/etc/init.d/system reload
uci set system.@system[0].hostname='Xiaomi'
(echo -e "IXWRT\nIXWRT" | passwd root) || (echo "root:IXWRT" | chpasswd)

#Reboot

reboot
