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
    ipv6_config="🟢 Enabled (Automatic)"
  elif [[ "$ipv6_value" == "Link-local only" ]]; then
    ipv6_config="🟡 Link-local only"
  elif [[ "$ipv6_value" == "Off" ]]; then
    ipv6_config="⚪ Off"
  else
    ipv6_config="🟡 Link-local only or not available"
  fi

  ipv6_pub=$(ifconfig "$main_dev" | grep inet6 | grep -v fe80 | awk '{print $2}' | xargs)

  echo "Welcome to use IPv6 Switcher!"
  echo "Author: https://x.com/tankxu"
  echo "-----------------------------"
  echo "Active interface: $main_dev"
  echo "Service name: $service"
  echo "IPv6 Switch:        $ipv6_config"
  if [[ -n "$ipv6_pub" ]]; then
    echo -e "IPv6 Address:       \033[32m$ipv6_pub\033[0m"
  else
    echo -e "IPv6 Address:       \033[31mNone\033[0m"
  fi
  echo "-----------------------------"
  if curl -6 -k --connect-timeout 3 "https://[2606:4700::6810:474]" >/dev/null 2>&1; then
    echo -e "IPv6 Connectivity:  \033[32m🟢 Reachable\033[0m"
  else
    echo -e "IPv6 Connectivity:  \033[31m🔴 Not reachable\033[0m"
  fi
  echo "-----------------------------"
}

while true; do
  show_status
  echo "Actions:"
  echo "1. Toggle IPv6"
  echo "2. Refresh"
  echo "3. Exit"
  read -p "Please select an action (1/2/3): " ans
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
      echo "Switching to Link-local only..."
      sudo networksetup -setv6linklocal "$service"
    else
      echo "Switching to Automatic (enable IPv6)..."
      sudo networksetup -setv6automatic "$service"
    fi
    echo "Done. Press Enter to refresh status..."
    read
  elif [[ "$ans" == "2" ]]; then
    continue
  elif [[ "$ans" == "3" ]]; then
    echo "Goodbye!"
    exit 0
  else
    echo "Invalid input. Please enter 1, 2 or 3."
  fi
done
