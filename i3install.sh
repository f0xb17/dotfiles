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
    "bluez"
    "bluez-utils"
    "cups"
    "cups-pdf"
    "zsh"
    "which"
    "github-cli"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
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

echo "### --- yay installation finished --- ###"

echo "###################################"
echo "#         Installing zsh          #"
echo "###################################"

echo "### --- Fetching oh-my-zsh --- ###"

mkdir zsh && cd zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
cd ../
rm -rf zsh

echo "### --- Enter Password to set zsh as standard shell --- ###"

chsh -s $(which zsh) 

echo "### --- Installing oh-my-zsh Plugins --- ###"

git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete


echo "###################################"
echo "#         Copying Config          #"
echo "###################################"

mkdir /home/$(whoami)/.config/archconf/

mv etc/environment /home/$(whoami)/.config/archconf/
mv etc/makepkg.conf /home/$(whoami)/.config/archconf/
mv etc/mkinitcpio.conf /home/$(whoami)/.config/archconf/
mv etc/cmdline.d/ /home/$(whoami)/.config/archconf/

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

echo "### --- Creating Symlinks --- ###"

sudo ln -sf /home/$(whoami)/.config/archconf/environemnt /etc/
sudo ln -sf /home/$(whoami)/.config/archconf/makepkg.conf /etc/
sudo ln -sf /home/$(whoami)/.config/archconf/mkinitcpio.conf /etc/
sudo ln -sf /home/$(whoami)/.config/archconf/root.conf /etc/cmdline.d/

echo "###################################"
echo "#        Starting Services        #"
echo "###################################"

echo "### --- nVidia Services --- ###"

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service

echo "### --- CUPS Service --- ###"

sudo systemctl enable cups.service
sudo systemctl enable cups.socket
sudo systemctl start cups.service

echo "### --- Bluetooth Service --- ###"

modprobe btusb
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

echo "### --- UFW Firewall Service --- ###"

sudo ufw default reject
sudo ufw enable
sudo systemctl enable ufw.service

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
