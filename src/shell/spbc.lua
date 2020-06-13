
--- Spacebear Commands (spbc)
-- Created by Olsken on 13/6/2020
-- Standard commands for Spacebear

local spbc = {}

local cfg = require("cfg")
local util = require("util")
local writer = require("shell/writer")

local terminal = Util.optStorage(TheoTown.getStorage(), "&spb_terminal")

local spb_commands = {
  ["version"] = function()
    writer.println(
      {cfg.name.." version: "..cfg.version}
    )
  end,
  ["clear"] = function()
    terminal.lines = setmetatable({}, getmetatable(terminal.lines))
    writer.new_line()
    terminal.halt_output = true
  end,
}

--- Searches spbc commands
-- ctable = command table
function spbc.search(ctable)
  local status = util.function_list(spb_commands, ctable[1], ctable[2])
  if status ~= "not found" then
    return true
  end
  return false
end

return spbc
