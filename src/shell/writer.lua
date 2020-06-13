
--- Writer for Spacebear terminal
-- Created by Olsken on 7/6/2020

local writer = {}

local cfg = require("cfg")

local terminal = Util.optStorage(TheoTown.getFileStorage(), "&spb_terminal")

--- Inserts string in current terminal line
function writer.print(content, colours)
  if content then
    terminal.lines("insert", content, "content")
  end
  if colours then
    terminal.lines("insert", colours, "colours")
  end
end

--- Creates new line then inserts string in that line
function writer.println(content, colours)
  terminal.lines("new")
  writer.print(content, colours)
end

function writer.new_line()
  writer.println(
    {"root/Users/Olsken", ">", false, "Hello ", "World"},
    {[2] = cfg.theme.seperator}
  )
end

function writer.new_state()
  writer.println({cfg.name.." version: "..cfg.version})
  writer.println({""})
  writer.new_line()
end

return writer
