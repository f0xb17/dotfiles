#!/bin/sh

echo "###################################"
echo "#         System Update           #"
echo "###################################"

sudo pacman -Syu

echo "###################################"
echo "#     Installing Sys-Packages     #"
echo "###################################"

echo "### --- Software Removal: vim --- ###"

sudo pacman -Rcns vim

apps=(
    "git"
    "feh"
    "rofi"
    "polybar"
    "picom"
    "alacritty"
    "nwg-look"
    "flameshot"
    "flatpak"
    "gnome-keyring"
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
    "ranger"
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
    "bitwarden"
    "discord"
    "nvidia-settings"
    "vlc"
    "obs-studio"
    "solaar"
    "gufw"
    "alacritty"
    "cmake"
    "clang"
    "ninja"
    "gdb"
    "nodejs"
    "npm"
    "python"
    "jdk-openjdk"
    "kotlin"
    "ttf-meslo-nerd"
    "powerline-fonts"
    "noto-fonts-cjk"
    "noto-fonts-extra"
    "noto-fonts-emoji"
    "ttf-hack-nerd"
    "ttf-jetbrains-mono-nerd"
    "noto-fonts"
    "tmux"
    "xorg-xrandr"
    "polkit-gnome"
)

for app in "${apps[@]}"; do
    echo "----------------------------------"
    echo "Installing: ${app}"
    echo "----------------------------------"
    sudo pacman -S --needed --noconfirm ${app}
done

echo "### --- Installation done --- ###"

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

echo "### --- Enter Password to set zsh as standard shell --- ###"

chsh -s $(which zsh) 

echo "###################################"
echo "#         Copying Config          #"
echo "###################################"

mkdir /home/$(whoami)/.config/archconf/
sudo mkdir /etc/cmdline.d/

mv etc/environment /home/$(whoami)/.config/archconf/
mv etc/makepkg.conf /home/$(whoami)/.config/archconf/
mv etc/mkinitcpio.conf /home/$(whoami)/.config/archconf/
mv etc/cmdline.d/ /home/$(whoami)/.config/archconf/

mv .config/alacritty /home/$(whoami)/.config/
rm -rf /home/$(whoami)/.config/i3
mv .config/i3 /home/$(whoami)/.config/
mv .config/picom /home/$(whoami)/.config/
mv .config/polybar /home/$(whoami)/.config/
mkdir /home/$(whoami)/.config/polybar/scripts
mv .config/rofi /home/$(whoami)/.config/
mkdir /home/$(whoami)/.themes
mv .themes/rofi /home/$(whoami)/.themes
mv .themes/alacritty /home/$(whoami)/.themes
mv .Xresources /home/$(whoami)/
mv .zshrc /home/$(whoami)/
mv .zsh_aliases /home/$(whoami)/
mv .tmux.conf /home/$(whoami)/

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

echo "### --- Enable SSD Trim --- ###"

sudo systemctl enable fstrim.timer

echo "###################################"
echo "#         Git things up           #"
echo "###################################"

echo "### --- Fetching Spotify Polybar --- ###"

sudo pacman -S --needed --noconfirm python-distutils-extra playerctl
yay -S --noconfirm zscroll-git
git clone https://github.com/PrayagS/polybar-spotify.git
cd polybar-spotify
mv get_spotify_status.sh /home/$(whoami)/.config/polybar/scripts/
mv scroll_spotify_status.sh /home/$(whoami)/.config/polybar/scripts/
cd ../
rm -rf polybar-spotify

echo "### --- Fetching tmux Plugin Manager --- ###"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "###################################"
echo "#           AUR Packages          #"
echo "###################################"

aurapps=(
    "intellij-idea-ultimate-edition"
    "intellij-idea-ultimate-edition-jre"
    "visual-studio-code-bin"
    "brother-mfc-l2710dw"
    "etcher-bin"
    "brave-bin"
    "zoom"
    "swift-bin"
    "rofi-power-menu"
)

for aurapp in "${aurapps[@]}"; do
    echo "----------------------------------"
    echo "Installing AUR-app: ${aurapp}"
    echo "----------------------------------"
    yay -S --noconfirm ${aurapp}
done

echo "### --- Installation done --- ###"

echo "### --- Change Folder Permissions: VS-Code --- ###"
sudo chown -R $(whoami) /opt/visual-studio-code

echo "###################################"
echo "#     Finishing Installation      #"
echo "###################################"

yay -Scc
yay -Yc

sudo mkinitcpio -P

echo "Installation finished. Performing reboot now?"
echo "Press enter to continue..."
read

reboot
