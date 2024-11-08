#!/bin/sh

echo "### COPY FISH & INSTALL PLUGINS ###"

mv .config/fish/config.fish ~/.config/fish/
mv .config/fish/fish_plugins ~/.config/fish/
fisher update

echo "### INSTALL KITTY CONFIG ###"

mv .config/kitty/ ~/.config/

echo "### INSTALL ROFI ###"

mkdir ~/.themes/
mv .config/rofi ~/.config/
mv .themes/rofi ~/.themes/

echo "### STARSHIP THEME ###"

starship preset pastel-powerline -o ~/.config/starship.toml
