local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local naughty = require("naughty")
local gears = require("gears")

local theme = {}
local notify = naughty.config

theme.font          = "sans 8"

theme.bg_normal     = "#1E2326"
theme.bg_focus      = "#272E33"
theme.bg_urgent     = "#E67E80"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#272E33"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(5)
theme.gap_single_client = true
theme.border_width  = dpi(4)
theme.border_normal = "#272E33"
theme.border_focus  = "#CE7B2A"

notify.defaults.timeout = 5
notify.defaults.icon_size = dpi(50)
notify.defaults.margin = dpi(16)
notify.defaults.width = dpi(512)
notify.defaults.border_width = dpi(2)
notify.padding = dpi(50)
notify.spacing = dpi(10)

notify.presets.low.opacity = 0.8
notify.presets.normal.opacity = 0.8
notify.presets.critical.opacity = 0.8

notify.presets.normal.bg = "#1E2326"
notify.presets.normal.fg = "#D3C6AA"
notify.presets.low.bg = "#1E2326"
notify.presets.low.fg = "#D3C6AA"
notify.presets.critical.bg = "#E67E80"
notify.presets.critical.fg = "#ffffff"

theme.notification_font = "FiraCode Nerd Font Propo Semibold 14"

notify.presets.normal.border_color = "#CE7B2A"
notify.presets.low.border_color = "#CE7B2A"
notify.presets.critical.border_color = "#cc241d"

theme.wallpaper = gears.filesystem.get_configuration_dir() .. "01.jpg"

return theme
