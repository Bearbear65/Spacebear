
--- Draws Spacebear terminal output
-- Created by Olsken on 6/6/2020

local output = {}

local cfg = require("cfg")
local util = require("util")

local terminal = Util.optStorage(TheoTown.getFileStorage(), "&spb_terminal")

local caret
function output.load_graphics()
  caret = Draft.getDraft("$spb_graphics_caret")
end

local function draw_caret(x, y)
  if #terminal.lines > 0 then
    local frame = math.floor(Runtime.getTime() / 600 % (caret:getFrameCount() + 1))

    Drawing.setColor(util.hex(cfg.theme.caret))
    Drawing.drawImage(caret:getFrame(frame), x, y)
    Drawing.reset()
  end
end

local function draw_terminal_line(line, index, x, y)
  Drawing.setColor(util.hex(line.colours[index]))
  Drawing.drawText(line.content[index], x, y, cfg.font)
  Drawing.reset()
end

local function set_view_scope()
  if not terminal.view_scope_lock then
    if #terminal.lines > cfg.view_scope then
      terminal.start_index = (#terminal.lines - cfg.view_scope) + 1
    else
      terminal.start_index = 1
    end
    terminal.end_index = #terminal.lines
  end
end

function output.terminal_lines()
  local cursorX = cfg.x + cfg.output_margin
  local cursorY = cfg.y + cfg.output_margin
  set_view_scope()

  for i = terminal.start_index, terminal.end_index do
    cursorX = cfg.x + cfg.output_margin
    for j = 1, #terminal.lines[i].content do
      if type(terminal.lines[i].content[j]) == "boolean" then goto continue end
      draw_terminal_line(terminal.lines[i], j, cursorX, cursorY)
      cursorX = cursorX + cfg.font:getWidth(terminal.lines[i].content[j])
      ::continue::
    end
    cursorY = cursorY + 10
  end
  draw_caret(cursorX, cursorY - 8)
end

return output
