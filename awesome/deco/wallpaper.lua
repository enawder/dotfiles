local beautiful = require("beautiful")
local gears = require("gears")

local wallpaper = {}

function wallpaper.set(screen)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(screen)
        end
        gears.wallpaper.maximized(wallpaper, screen, true)
    end
end

return wallpaper
