
--- Run commands for Spacebear
-- Created by Olsken on 13/6/2020

local command = {}

local util = require("util")
local spbc = require("shell/spbc")

local terminal = Util.optStorage(TheoTown.getStorage(), "&spb_terminal")

local function cut_directory(raw_content)
  assert(type(raw_content) == "table")

  local count
  for i = 1, #raw_content do
    if raw_content[i] == false then
      count = i
    end
  end
  if not count then return raw_content end
  for i = 1, count do
    table.remove(raw_content, 1)
  end
  return raw_content
end

function command.execute()
  local status = false
  local raw_content = util.quick_copy(terminal.lines("get_raw_data", "content"))

  raw_content = cut_directory(raw_content)
  if #raw_content[1] == 0 then return status end
  raw_content[1] = raw_content[1]:gsub(" ", ""):lower()
  status = spbc.search(raw_content)
  return status
end

return command
