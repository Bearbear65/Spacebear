
--- Spacebear Commands (spbc)
-- Created by Olsken on 13/6/2020
-- Standard commands for Spacebear

local spbc = {}

local cfg = require("cfg")
local util = require("util")
local writer = require("shell/writer")

local terminal = Util.optStorage(TheoTown.getStorage(), "&spb_terminal")
local keyboard = Util.optStorage(TheoTown.getStorage(), "&spb_keyboard")

local spb_commands = {
  ["version"] = function()
    writer.println{cfg.name.." version: "..cfg.version}
    return true
  end,
  ["clear"] = function()
    terminal.lines = setmetatable({}, getmetatable(terminal.lines))
    writer.new_line()
    terminal.halt("input")
    return true
  end,
  ["exit"] = function()
    terminal.lines = setmetatable({}, getmetatable(terminal.lines))
    terminal.visible = false
    terminal.view_scope_lock = false
    keyboard.shifted = false
    keyboard.capslock = false
    writer.new_state()
    terminal.halt("all")
    return true
  end
}

--- Searches spbc commands
function spbc.search(data)
  return util.function_table(spb_commands, data[1], data[2])
end

return spbc
