
--- Status messages for Spacebear
-- Created by Olsken on 13/6/2020

local status = {}

local cfg = require("cfg")
local writer = require("shell/writer")

local terminal = Util.optStorage(TheoTown.getStorage(), "&spb_terminal")

function status.throw_error(msg)
  writer.println(
    {":( ", msg},
    {[1] = cfg.theme.error}
  )
  writer.println({""})
  writer.new_line()
  terminal.halt("all")
end

return status
