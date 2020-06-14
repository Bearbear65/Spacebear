
--- Input file for Spacebear terminal
-- Created by Olsken on 7/6/2020

local input = {}

local cfg = require("cfg")
local util = require("util")
local writer = require("shell/writer")
local command = require("shell/command")

local terminal = Util.optStorage(TheoTown.getStorage(), "&spb_terminal")
local keyboard = Util.optStorage(TheoTown.getStorage(), "&spb_keyboard")

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
      local status = command.execute()
      if status then
        writer.println{""}
      end
      writer.new_line()
      terminal.halt = setmetatable({}, getmetatable(terminal.halt))
    end,
    ["space"] = function()
      terminal.lines("append", " ")
    end,
    ["shift"] = function()
      keyboard.shifted = not keyboard.shifted
    end,
    ["capslock"] = function()
      keyboard.capslock = not keyboard.capslock
    end
  },
}

local function set_highlight()
  if terminal.lines("get_element", "content", -1) == false then
    terminal.lines("insert", {[#terminal.lines[#terminal.lines].content] = cfg.theme.highlight}, "colours")
    if terminal.lines("get_element", "content"):match("%s*%S+%s") then
      terminal.lines("insert", {""}, "content")
    end
  end
end

function input.write(char)
  if not char then return end
  if char:match("^_.+") then
    util.function_table(special_key_functions[char:match("^_(.+):")], char:match(":(.+)$"))
  else
    terminal.lines("append", char)
    keyboard.shifted = false
  end
  set_highlight()
end

return input
