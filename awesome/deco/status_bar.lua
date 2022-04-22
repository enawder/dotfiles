local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local tag_list = require("deco.tag_list")
local task_list = require("deco.task_list")
local wallpaper = require("deco.wallpaper")

local status_bar = {}

function status_bar.build()
    screen.connect_signal("property::geometry", wallpaper.set)

    awful.screen.connect_for_each_screen(function(s)
        wallpaper.set(s)
        awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, config.layouts[1])
        s.mypromptbox = awful.widget.prompt()
        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(
            gears.table.join(
                awful.button({ }, 1, function () awful.layout.inc( 1) end),
                awful.button({ }, 3, function () awful.layout.inc(-1) end),
                awful.button({ }, 4, function () awful.layout.inc( 1) end),
                awful.button({ }, 5, function () awful.layout.inc(-1) end)
            )
        )
        s.mytaglist = awful.widget.taglist {
            screen = s,
            filter = awful.widget.taglist.filter.all,
            buttons = tag_list.buttons()
        }
        s.mytasklist = awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            buttons = task_list.buttons()
        }
        s.mywibox = awful.wibar({ position = "top", screen = s })
        s.mywibox:setup {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                config.launcher,
                s.mytaglist,
                s.mypromptbox,
            },
            s.mytasklist,
            {
                layout = wibox.layout.fixed.horizontal,
                awful.widget.keyboardlayout(),
                wibox.widget.systray(),
                wibox.widget.textclock(),
                s.mylayoutbox,
            }
        }
    end)
end

return status_bar
