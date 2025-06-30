#!/bin/bash

show_status() {
  main_dev=$(route get default 2>/dev/null | awk '/interface: / {print $2}')
  service=$(networksetup -listallhardwareports | awk -v dev="$main_dev" '
    $1=="Hardware" && $2=="Port:" {port=$3}
    $1=="Device:" && $2==dev {print port}
  ')

  ipv6_config_line=$(networksetup -getinfo "$service" 2>/dev/null | grep "^IPv6:" | head -n 1)
  ipv6_value=""
  if [[ -n "$ipv6_config_line" ]]; then
    ipv6_value=$(echo "$ipv6_config_line" | awk -F': ' '{print $2}')
  fi

  if [[ "$ipv6_value" == "Automatic" ]]; then
    ipv6_config="🟢 已开启（自动）"
  elif [[ "$ipv6_value" == "Link-local only" ]]; then
    ipv6_config="🟡 仅本地链路"
  elif [[ "$ipv6_value" == "Off" ]]; then
    ipv6_config="⚪ 已关闭"
  else
    ipv6_config="🟡 仅本地链路或不可用"
  fi

  ipv6_pub=$(ifconfig "$main_dev" | grep inet6 | grep -v fe80 | awk '{print $2}' | xargs)

  echo "欢迎使用 IPv6 开关切换器！"
  echo "作者：https://x.com/tankxu"
  echo "-----------------------------"
  echo "当前主用接口: $main_dev"
  echo "服务名: $service"
  echo "IPv6 开关状态:      $ipv6_config"
  if [[ -n "$ipv6_pub" ]]; then
    echo -e "IPv6 地址:          \033[32m$ipv6_pub\033[0m"
  else
    echo -e "IPv6 地址:          \033[31m无公网IPv6\033[0m"
  fi
  echo "-----------------------------"
  if curl -6 -k --connect-timeout 3 "https://[2606:4700::6810:474]" >/dev/null 2>&1; then
    echo -e "IPv6 外网连通性:    \033[32m🟢 可连通\033[0m"
  else
    echo -e "IPv6 外网连通性:    \033[31m🔴 不可连通\033[0m"
  fi
  echo "-----------------------------"
}

while true; do
  show_status
  echo "操作菜单:"
  echo "1. 切换 IPv6 开关"
  echo "2. 刷新状态"
  echo "3. 退出"
  read -p "请选择操作（1/2/3）: " ans
  if [[ "$ans" == "1" ]]; then
    main_dev=$(route get default 2>/dev/null | awk '/interface: / {print $2}')
    service=$(networksetup -listallhardwareports | awk -v dev="$main_dev" '
      $1=="Hardware" && $2=="Port:" {port=$3}
      $1=="Device:" && $2==dev {print port}
    ')
    ipv6_config_line=$(networksetup -getinfo "$service" 2>/dev/null | grep "^IPv6:" | head -n 1)
    ipv6_value=""
    if [[ -n "$ipv6_config_line" ]]; then
      ipv6_value=$(echo "$ipv6_config_line" | awk -F': ' '{print $2}')
    fi
    if [[ "$ipv6_value" == "Automatic" ]]; then
      echo "切换为仅本地链路..."
      sudo networksetup -setv6linklocal "$service"
    else
      echo "切换为自动获取..."
      sudo networksetup -setv6automatic "$service"
    fi
    echo "切换完成，按回车刷新状态..."
    read
  elif [[ "$ans" == "2" ]]; then
    continue
  elif [[ "$ans" == "3" ]]; then
    echo "已退出。"
    exit 0
  else
    echo "输入有误，请输入 1、2 或 3。"
  fi
done
