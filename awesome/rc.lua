-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

require("error_handling")

config = {}
config.vars = require("user_variables")
config.menu = require("menu")
config.layouts = require("layouts")
config.client = require("binding.client")
config.global = require("binding.global")
config.rules = require("rules")
config.status_bar = require("deco.status_bar")

require("signals")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- This is used later as the default terminal and editor to run.

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = config.vars.modkey

config.main_menu = awful.menu({
    items = {
        { "awesome", config.menu, beautiful.awesome_icon },
        { "open terminal", config.vars.terminal }
    }
})

config.launcher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = config.main_menu
})

-- Menubar configuration
menubar.utils.terminal = config.vars.terminal -- Set the terminal for applications that require it
-- }}}

config.status_bar.build()

-- {{{ Mouse bindings
root.buttons(config.global.buttons())
-- }}}

-- Set keys
root.keys(config.global.keys())
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = config.rules.get(
    config.client.keys(),
    config.client.buttons()
)
