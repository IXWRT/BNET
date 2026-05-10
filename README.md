## If Wanna Reset
```
firstboot -y && reboot
```
## Startup Settings If You Want

```
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

```
---

## 🚀 Installation

```
cd /tmp && wget https://github.com/IXWRT/BNET/raw/main/install.sh && chmod +x install.sh && clear && sh install.sh && rm install.sh
```
---

## 🚀 Installation With Zero Error

```
cd /tmp && wget https://github.com/IXWRT/BNET/raw/main/installwithzeroerror.sh && chmod +x installwithzeroerror.sh && clear && sh installwithzeroerror.sh && rm installwithzeroerror.sh
```
---


## 🔧 Updating Proxy IP, Port, Username & Password

```
vi /etc/bdix.conf
```

After making changes:
- Press `Esc`, then type `:wq` to **save & exit**.
- Type `:q!` to **exit without saving**.
- To Clear `:%d`

<p align="center">
  <img src="https://i.imgur.com/8uLp8I9.png" alt="Update proxy IP, Port, Username & Password" width="500"/>
</p>

---

## 🏛 Managing BDIX Proxy Service

### Start BDIX Proxy Bypass
```
service bdix start
```

### Stop BDIX Proxy Bypass
```
service bdix stop
```

### Restart BDIX Proxy Bypass
```
service bdix restart
```

### Enable BDIX Auto Boot-Start
```
service bdix enable
```

### Disable BDIX Auto Boot-Start
```
service bdix disable
```

---

## 🔄 Updating Direct Connection List

```
vi /etc/init.d/bdix
```
After updating:
- Press `Esc`, then type `:wq` to **save & exit**.
- Type `:q!` to **exit without saving**.

## ❌ Uninstalling BDIX from OpenWRT

```
service bdix stop
service bdix disable
rm /etc/init.d/bdix
rm /etc/bdix.conf
```
