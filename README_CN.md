# macOS IPv6 Switcher

一个用于 macOS 的简易命令行工具，支持查看、切换和检测当前网络的 IPv6 状态。

[English instructions →](./README.md)

<br/>

## 功能特性

- 查看当前主用网络、IPv6 地址及连通性
- 一键切换 IPv6 模式（自动 / 仅本地链路）
- 实时公网 IPv6 连通性测试（Cloudflare IPv6: https://[2606:4700::6810:474]）

<img width="1035" alt="image" src="https://github.com/user-attachments/assets/f5abdd82-7808-44b4-b2e7-d9477c708a46" />
<img width="1035" alt="Image" src="https://github.com/user-attachments/assets/a950400e-d145-4f5e-ad8b-20d780c4784a" />

## 如何使用
### 方法 1: 安装应用
1. [下载 IPv6 Switcher 应用](https://github.com/tankxu/macos-ipv6-switcher/releases/download/v1.0.0/IPv6.Switcher.CN.zip)
2. 第一次打开时，可能需要右键点击 App，选择“打开”以通过系统安全校验。


### 方法 2: 快速体验（推荐）

> **警告：请先阅读脚本内容再运行！**

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tankxu/macos-ipv6-switcher/main/ipv6-switcher-cn.sh)"
```


### 方法 3: 手动下载安装
1.	下载脚本：
```bash
git clone https://github.com/tankxu/macos-ipv6-switcher.git
cd macos-ipv6-switcher
```

2.	添加执行权限：
```bash
chmod +x ipv6-switcher-cn.sh
```

3. 运行脚本：
```bash
./ipv6-switcher-cn.sh
```

<br/>

## 操作菜单

主菜单选项：

1.	切换 IPv6
2.	刷新状态
3.	退出

> **Note:** 切换 IPv6 模式需要管理员（root）权限，运行过程中会提示输入你的开机密码。


<br />

------------

<br />

#### 🔥 请关注我的 X，谢谢
[https://x.com/tankxu](https://x.com/tankxu)

<br />
