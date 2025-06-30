# macOS IPv6 Switcher

A simple CLI tool to check, toggle, and monitor the IPv6 status on your macOS network.  

[中文使用说明 →](./README_CN.md)

<br/>

## Features

- View active network, current IPv6 addresses, and IPv6 connectivity
- Toggle IPv6 mode (Automatic / Link-local only) with one click
- Real-time connectivity test (Cloudflare IPv6: https://[2606:4700::6810:474])
  
<img width="1016" alt="Image" src="https://github.com/user-attachments/assets/a2b7c973-36bb-40e4-be19-e9a3c4ee3baa" />
<img width="1035" alt="image" src="https://github.com/user-attachments/assets/706c4389-9aa0-4a1e-ace8-756f047063c8" />

## How to use

### Option 1: Install App
1. [Download IPv6 Switcher](https://github.com/tankxu/macos-ipv6-switcher/releases/download/v1.0.0/IPv6.Switcher.zip)
2. Open the App


### Option 2: Quick run

> **Warning**: Always review downloaded scripts before running them!

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tankxu/macos-ipv6-switcher/main/ipv6-switcher.sh)"
```


### Option 3:	Manual installation
1.	Download the script(s):
```bash
git clone https://github.com/tankxu/macos-ipv6-switcher.git
cd macos-ipv6-switcher
```

2.	Make executable:
```bash
chmod +x ipv6-switcher.sh
```

3. Run:
```bash
./ipv6-switcher.sh
```

<br/>

## Actions

Main menu options:

1. Toggle IPv6
2. Refresh status
3. Exit

> **Note:** Toggling the IPv6 mode requires administrator (root) privileges.  
> You'll be prompted for your password when running the script.

<br />

------------

<br />

#### 🔥 Follow me on X
[https://x.com/tankxu](https://x.com/tankxu)

<br />
