local awful = require("awful")

local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = config.vars.terminal .. " -e " .. editor

local menu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", config.vars.terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

return menu
