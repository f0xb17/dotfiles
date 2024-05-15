#!/bin/sh

echo "###################################"
echo "#      Installing i3 Packages     #"
echo "###################################"

apps=(
    "git"
    "rofi"
    "polybar"
    "picom"
    "alacritty"
    "gnome-keyring"
    "nwg-look"
    "flameshot"
    "flatpak"
    "xdg-desktop-portal"
    "xdg-desktop-portal-xapp"
    "xdg-desktop-portal-gtk"
    "thunar"
    "xarchiver"
    "pavucontrol"
    "base-devel"
    "neovim"
    "blueman"
    "system-config-printer"
)

for app in "${apps[@]}"; do
    echo "----------------------------------"
    echo "Installing: ${app}"
    echo "----------------------------------"
    sudo pacman -S --needed --noconfirm ${app}
done

echo "###################################"
echo "#         Installing yay          #"
echo "###################################"

git clone https://aur.archlinux.org/yay.git && cd yay
makepkg -si
cd ../
rm -rf yay

echo "###################################"
echo "#         Copying Config          #"
echo "###################################"

mv .config/alacrity /home/$(whoami)/.config/
mv .config/i3 /home/$(whoami)/.config/
mv .config/picom /home/$(whoami)/.config/
mv .config/polybar /home/$(whoami)/.config/
mkdir /home/$(whoami)/.config/polybar/scripts
mv .config/rofi /home/$(whoami)/.config/
mkdir /home/$(whoami)/.themes
mv .themes/rofi /home/$(whoami)/.themes
mv .Xressources /home/$(whoami)/
mv .zshrc /home/$(whoami)/
mv .zshaliases /home/$(whoami)/

echo "###################################"
echo "#         Git things up           #"
echo "###################################"

echo "### --- Fetching Alacritty Themes --- ###"

git clone https://github.com/alacritty/alacritty-theme.git
mkdir /home/$(whoami)/.themes/alacritty-theme/
cd alacritty-theme/themes/ && mv gruvbox_dark.toml /home/$(whoami)/.themes/alacritty-themes/
cd ../../
rm -rf alacritty-theme

echo "### --- Fetching Spotify Polybar --- ###"

sudo pacman -S --needed --noconfirm python-distutils-extra playerctl
yay -S --noconfirm zscroll-git
git clone https://github.com/PrayagS/polybar-spotify.git
cd polybar-spotify
mv get_spotify_status.sh /home/$(whoami)/.config/polybar/scripts/
mv scroll_spotify_status.sh /home/$(whoami)/.config/polybar/scripts/
cd ../
rm -rf polybar-spotify
