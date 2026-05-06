
## 🚀 Installation

```
cd /tmp && wget https://github.com/IXWRT/BNET/raw/main/install.sh && chmod +x install.sh && clear && sh install.sh && rm install.sh
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
