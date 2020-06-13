
--- Input file for Spacebear terminal
-- Created by Olsken on 7/6/2020

local input = {}

local writer = require("shell/writer")
local util = require("util")

local terminal = Util.optStorage(TheoTown.getFileStorage(), "&spb_terminal")
local keyboard = Util.optStorage(TheoTown.getFileStorage(), "&spb_keyboard")

-- NOTE: think of a better name :/

local special_key_functions = {
  ["type"] = {
    ["delete"] = function()
      local last_element = terminal.lines("get_element", "content")
      if #last_element == 0 then
        if terminal.lines("get_element", "content", -1) == false then return end
        terminal.lines("remove", "content")
        last_element = terminal.lines("get_element", "content")
      end
      terminal.lines("remove", "content")
      terminal.lines("insert", {last_element:sub(1, -2)}, "content")
    end,
    ["enter"] = function()
      writer.new_line()
    end,
    ["shift"] = function()
      keyboard.shifted = not keyboard.shifted
    end,
    ["capslock"] = function()
      keyboard.capslock = not keyboard.capslock
    end
  },
}

function input.write(char)
  if not char then return end
  if char:match("^_.+") then
    util.function_list(special_key_functions[char:match("^_(.+):")], char:match(":(.+)$"))
  else
    terminal.lines("append", char)
    keyboard.shifted = false
  end
end

return input
