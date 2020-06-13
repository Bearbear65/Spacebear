
--- Draws Spacebear terminal
-- Created by Olsken on 6/6/2020

local gui = {}

local cfg = require("cfg")
local util = require("util")

local terminal = Util.optStorage(TheoTown.getStorage(), "&spb_terminal")

local texture, icon
function gui.load_graphics()
  texture = Draft.getDraft("$spb_graphics_texture"):getFrame(1)
  icon = Draft.getDraft("$spb_graphics_icon")
end

function gui.draw_main_window()
  Drawing.setColor(util.hex(cfg.theme.main_window))
  Drawing.drawImageRect(texture, cfg.x, cfg.y, cfg.w, cfg.h)
  Drawing.reset()
end

function gui.draw_statusbar()
  Drawing.setColor(util.hex(cfg.theme.statusbar))
  Drawing.drawImageRect(texture, cfg.x, (cfg.y + cfg.h) - cfg.statusbar_height, cfg.w, cfg.statusbar_height)
  Drawing.reset()
end

function gui.draw_title()
  Drawing.setColor(util.hex(cfg.theme.title))
  Drawing.drawText(cfg.name, cfg.x + 2, (cfg.y + cfg.h) - 12, cfg.font)
  Drawing.reset()
end

function gui.draw_clock()
  local time = os.date("%H")..":"..os.date("%M")
  Drawing.setColor(util.hex(cfg.theme.title))
  Drawing.drawText(time, (cfg.x + cfg.w) - cfg.font:getWidth(time) - 1, (cfg.y + cfg.h) - 12, cfg.font)
  Drawing.reset()
end

function gui.draw_icon()
  local frame = math.floor(Runtime.getTime() / 150 % (icon:getFrameCount() + 1))
  local height = select(2, Drawing.getSize())
  Drawing.drawImage(icon:getFrame(frame), 35, height - 30)
  Drawing.reset()
end

function gui.icon_was_tapped(x, y)
  local height = select(2, Drawing.getSize())
  if x >= 35 and x <= 56 and y >= height - 30 and y <= height - 17 then
    terminal.visible = not terminal.visible
    return true
  end
end

function gui.was_tapped(x, y)
  if x >= cfg.x and x <= cfg.x + cfg.w and y >= cfg.y and y <= cfg.y + cfg.h then
    return true
  end
end

return gui
