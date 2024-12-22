#!/bin/bash

# ---------------------------------------------

echo "### Systemupdate ###"

sudo pacman -Syyu

# ---------------------------------------------

if [[ "$2" == "--kitty" ]]; then
  echo "### Kitty ###"
  sudo pacman -S --needed --noconfirm kitty

  echo "-- Creating Kitty Folder"
  mkdir -p ~/.config/kitty

  echo "-- Kitty Config"
  ln -sf $PWD/config/kitty/kitty.conf ~/.config/kitty/
  
  echo "-- Kitty Theme"
  ln -sf $PWD/config/kitty/current-theme.conf ~/.config/kitty/
fi

# ---------------------------------------------

echo "### Helix ###"

sudo pacman -S --needed --noconfirm helix

echo "-- Creating Helix Folder(s)"
mkdir -p ~/.config/helix
mkdir -p ~/.config/helix/themes

echo "-- Helix Config"  
ln -sf $PWD/config/helix/config.toml ~/.config/helix/

echo "-- Helix Languages"
ln -sf $PWD/config/helix/languages.toml ~/.config/helix/

echo "-- Helix Theme"
ln -sf $PWD/config/helix/themes/tokyotrans.toml ~/.config/helix/themes/

# ---------------------------------------------

echo "### Rofi ###"

sudo pacman -S --needed --noconfirm rofi

echo "-- Creating Rofi Folder(s)"
mkdir -p ~/.config/rofi
mkdir -p ~/.config/rofi/themes

echo "-- Rofi Config"
ln -sf $PWD/config/rofi/config.rasi ~/.config/rofi/

echo "-- Rofi Theme"
ln -sf $PWD/config/rofi/themes/dmenu.rasi ~/.config/rofi/themes/

# ---------------------------------------------

if [[ "$1"  == "--qtile" || "$1" == "--bspwm" ]]; then
 
  echo "### .Xresources ###"

  echo "-- Creating .Xresources"
  ln -sf $PWD/config/scripts/.Xresources ~/

  echo "### Polybar ###"

  sudo pacman -S --needed --noconfirm polybar

  echo "-- Creating Polybar Folder(s)"
  mkdir -p ~/.config/polybar

  echo "-- Polybar Config"
  ln -sf $PWD/config/polybar/config.ini ~/.config/polybar/

  echo "-- Polybar Theme"
  ln -sf $PWD/config/polybar/colors.ini ~/.config/polybar/

  echo "-- Polybar Modules"
  ln -sf $PWD/config/polybar/modules.ini ~/.config/polybar/

  # ---------------------------------------------

  echo "### Dunst ###"

  sudo pacman -S --needed --noconfirm dunst

  echo "-- Creating Dunst Folder(s)"
  mkdir -p ~/.config/dunst

  echo "-- Dunst Config"
  ln -sf $PWD/config/dunst/dunstrc ~/.config/dunst/

  # ---------------------------------------------

  echo "### Picom ###"

sudo pacman -S --needed --noconfirm picom

  echo "-- Creating Picom Folder(s)"
  mkdir -p ~/.config/picom

  echo "-- Picom Config"
  ln -sf $PWD/config/picom/picom.conf ~/.config/picom/

  echo "### Install X11-Packages ###"
  sudo pacman -S --needed --noconfirm maim feh xdg-desktop-portal playerctl xorg-setxkbmap nwg-look xdg-desktop-portal-gtk

  echo "### Install Gnome-Keyring Packages ###"
  sudo pacman -S --needed --noconfirm gnome-keyring libsecret polkit-gnome
fi

# ---------------------------------------------

echo "### WM Configuration ###"

if [[ "$1" == "--bspwm" ]]; then
  echo "-- Creating BSPWM Folder(s)"
  mkdir -p ~/.config/bspwm
  ln -sf $PWD/config/bspwm/bspwmrc ~/.config/bspwm/
  chmod 755 $PWD/config/bspwm/bspwmrc

  echo "-- Creating SXHKD Folder(s)"
  mkdir -p ~/.config/sxhkd
  ln -sf $PWD/config/sxhkd/sxhkdrc ~/.config/sxhkd/
  chmod 644 $PWD/config/bspwm/sxhkdrc
fi

if [[ "$1" == "--qtile" ]]; then
  echo "-- Creating Qtile Folder(s)"
  mkdir -p ~/.config/qtile
  ln -sf $PWD/config/qtile/config.py ~/.config/qtile/
fi

# ---------------------------------------------

echo "### fish ###"

sudo pacman -S --needed --noconfirm fish
chsh -s $(which fish)

echo "-- Creating fish Folder(s)"
mkdir -p ~/.config/fish

echo "-- fish Config"
ln -sf $PWD/config/fish/config.fish ~/.config/fish/

echo "--fisher plugins"
ln -sf $PWD/config/fish/fish_plugins ~/.config/fish/

# ---------------------------------------------

echo "### Starship ###"

sudo pacman -S --needed --noconfirm starship

starship preset nerd-font-symbols -o ~/.config/starship.toml

# ---------------------------------------------

echo "### Fastfetch ###"

sudo pacman  -S --needed --noconfirm fastfetch

echo "-- Creating Fastfetch Folder(s)"
mkdir -p ~/.config/fastfetch

echo "-- Fastfetch Config"
ln -sf $PWD/config/fastfetch/linus.jsonc ~/.config/fastfetch/

# ---------------------------------------------

echo "### Installing AUR & YAY ####"

sudo pacman -S --needed --noconfirm base-devel

echo "-- Installed base-devel Package"

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd ../ && rm -rf yay

echo "-- Installed AUR Helper: yay"

# ---------------------------------------------

echo "### Installing Software ###"

pkgs=(
  "git"
  "bluez"
  "bluez-utils"
  "cups"
  "cups-pdf"
  "fish"
  "which"
  "github-cli"
  "fzf"
  "ufw"
  "zoxide"
  "exa"
  "unrar"
  "unzip"
  "zip"
  "p7zip"
  "libheif"
  "ntfs-3g"
  "fastfetch"
  "zlib"
  "zenity"
  "zxing-cpp"
  "xvidcore"
  "wget"
  "whois"
  "usbutils"
  "aspell"
  "aspell-de"
  "earlyoom"
  "rsync"
  "reflector"
  "bat"
  "fd"
  "fisher"
  "starship"
  "xclip"
  "tree"
  "python-psutil"
  "xorg-xprop"
  "wmctrl"
  "pavucontrol"
  "blueman"
# ----------- #  
  "bitwarden"
  "vlc"
  "obs-studio"
  "gufw"
  "linux-firmware-qlogic"
  "spotify-launcher"
  "helix"
# ---------- # 
  "cmake"
  "clang"
  "ninja"
  "gdb"
  "python"
  "go"
  "npm"
  "nodejs"
  "kotlin"
# ---------- # 
  "ttf-meslo-nerd"
  "powerline-fonts"
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-extra"
  "noto-fonts-emoji"
  "ttf-firacode-nerd"
)

for pkg in "${pkgs[@]}"; do
  echo "-- Installing: $pkg"
  sudo pacman -S --needed --noconfirm ${pkg}
done

if [[ "$3" == "--moz" ]]; then
  sudo pacman -S --needed --noconfirm firefox-developer-edition firefox-developer-edition-i18n-de
  echo "-- Installed Mozilla Firefox Developer Edition / German Language Pack"
elif [[ "$3" == "--brave" ]]; then
  yay -S --noconfirm brave-bin
  echo "-- Installed Brave Browser"
elif [[ "$3" == "--mb" ]]; then
  sudo pacman -S --needed --noconfirm firefox-developer-edition firefox-developer-edition-i18n-de
  yay -S --noconfirm brave-bin
  echo "-- Installed Mozilla Firefox Developer Edition / German Language Pack and Brave Browser"
elif [[ "$3" == "" ]]; then
  echo "-- No Browser Installed. Choose later!"
fi 

# ---------------------------------------------

aurpkgs=(
  "brother-mfc-l2710dw"
  "zoom"
  "aic94xx-firmware"
  "wd719x-firmware"
  "upd72020x-fw"
  "ast-firmware"
  "visual-studio-code-bin"
  "anydesk-bin"
  "discord-canary"
  "discord-canary-wayland-hook"
  "intellij-idea-community-edition-jre"
  "jdk-temurin"
  "zscroll-git"
  "github-desktop-bin"
)

for pkg in ${aurpkgs[@]}; do
  echo "-- Installing: $pkg"
  yay -S --noconfirm ${pkg}
done

# ---------------------------------------------

echo "### Starting Services ###"

sudo systemctl enable cups.service
sudo systemctl enable cups.socket
sudo systemctl start cups.service
echo "-- CUPS Services started"

modprobe btusb
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
echo "-- Bluetooth Service Started"

sudo ufw default reject
sudo ufw enable
sudo systemctl enable ufw.service
echo "-- Firewall Service started, set to Incoming: Reject"

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
echo "-- nvidia Services Enabled"

# ---------------------------------------------

echo "### Installing Helix LS ###"

sudo npm i -g vscode-langservers-extracted
sudo npm install -g typescript typescript-language-server

yay -S --needed --noconfirm python-pylsp-mypy
yay -S --needed --noconfirm marksman-bin
yay -S --needed --noconfirm kotlin-language-server
yay -S --needed --noconfirm jdtls

sudo pacman -S --needed --noconfirm pyright python-ruff

go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# ---------------------------------------------

echo "### Finishing ###"

yay -Scc
yay -Yc
echo "-- Cleaning Packages done"

sudo mkinitcpio -P
echo "-- Rebuilding Mikintcpio done"

# o----------------------------------------------

echo "-- Installation Finished"
echo "-- Press enter to continue --"
read

reboot

