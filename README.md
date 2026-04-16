# my Setup

all you need is: pacman -S git fzf

bash script to install my tools

./run --dry <nameApp_toInstall>  
./run --dry

./dev-env --dry <nameFile_toCopy>  
./dev-env --dry

## wifi connection

first install iwd

```
paru -S iwd
```

```
rfkill list
rfkill unblock wifi
rfkill unblock all
iwctl
device wlan0 set-property Powered on
station wlan0 scan
station wlan0 get-networks
station wlan0 connect "Your_SSID_Name"
```

## fix nm-connection-editor

```
systemctl status NetworkManager
sudo systemctl enable --now NetworkManager
```

Create/Edit /etc/NetworkManager/conf.d/wifi_backend.conf

```
[device]
wifi.backend=iwd
```

sudo systemctl restart NetworkManager

## others

```
faillock --user nobilis --reset
```

sudo nvim /etc/pam.d/system-auth

```
/etc/pam.d/system-auth
```
