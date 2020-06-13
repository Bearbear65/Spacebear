
--- Spacebear terminal
-- Created by Olsken on 6/6/2020

require("fs/memory")
local cfg = require("cfg")
local gui = require("gui")
local keyboard = require("keyboard")
local output = require("output")
local input = require("shell/input")
local writer = require("shell/writer")

function script:init()
  gui.load_graphics()
  output.load_graphics()
  keyboard.load_graphics()
  keyboard.build()
  writer.new_state()

  TheoTown.registerCommand("spacebear", function()
    return "Running "..cfg.name.." version: "..cfg.version
  end)
end

function script:update()
  gui.draw_main_window()
  gui.draw_statusbar()
  gui.draw_title()
  gui.draw_clock()
  keyboard.draw()
  output.terminal_lines()
  Drawing.drawText(collectgarbage("count"), 250, 120)
end

function script:earlyTap(_, _, x, y)
  local keyboard_output = keyboard.input(x, y)
  input.write(keyboard_output)
  if gui.was_tapped(x, y) or keyboard_output then
    return false
  end
end
