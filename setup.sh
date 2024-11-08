#!/bin/sh

echo "### COPY FISH & INSTALL PLUGINS ###"

mv .config/fish/ ~/.config/
fisher update

echo "### INSTALL KITTY CONFIG ###"

mv .config/kitty/ ~/.config/

echo "### INSTALL ROFI ###"

mkdir ~/.themes/
mv .config/rofi ~/.config/
mv .themes/rofi ~/.themes/

echo "### STARSHIP THEME ###"

starship preset pastel-powerline -o ~/.config/starship.toml
