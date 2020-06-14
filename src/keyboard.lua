
--- Keyboard for Spacebear
-- Created by Olsken on 12/6/2020

local cfg = require("cfg")
local util = require("util")

local keyboard = {}

local keyboard_memory = Util.optStorage(TheoTown.getStorage(), "&spb_keyboard")

local texture
function keyboard.load_graphics()
  texture = Draft.getDraft("$spb_graphics_texture"):getFrame(1)
end

local structure = {}

local function build_special_keys()
  structure[#structure + 1] = {
    x = cfg.key_x + (cfg.key_size + cfg.key_gap) * 13,
    y = cfg.key_y,
    w = cfg.key_size * 1.5,
    h = cfg.key_size,
    key = "_type:delete",
  }
  structure[#structure + 1] = {
    x = cfg.key_x + (cfg.key_size + cfg.key_gap) * 12 + cfg.key_indent * 2,
    y = cfg.key_y + (cfg.key_size + cfg.key_gap) * 2,
    w = cfg.key_size * 1.5 + cfg.key_gap,
    h = cfg.key_size,
    key = "_type:enter",
  }
  structure[#structure + 1] = {
    x = cfg.key_x,
    y = cfg.key_y + (cfg.key_size + cfg.key_gap) * 3,
    w = cfg.key_size * 2.5,
    h = cfg.key_size,
    key = "_type:shift",
  }
  structure[#structure + 1] = {
    x = cfg.key_x + cfg.key_size * 12.5 + cfg.key_gap * 11,
    y = cfg.key_y + (cfg.key_size + cfg.key_gap) * 3,
    w = cfg.key_size * 2 + cfg.key_gap * 2,
    h = cfg.key_size,
    key = "_type:shift",
  }
  structure[#structure + 1] = {
    x = cfg.key_x,
    y = cfg.key_y + (cfg.key_size + cfg.key_gap) * 2,
    w = cfg.key_size * 2,
    h = cfg.key_size,
    key = "_type:capslock",
  }
  structure[#structure + 1] = {
    x = cfg.key_x + (cfg.key_size + cfg.key_gap) * 4.5,
    y = cfg.key_y + (cfg.key_size + cfg.key_gap) * 4,
    w = (cfg.key_size + cfg.key_gap) * 6,
    h = cfg.key_size,
    key = "_type:space",
  }
end

--- Builds keyboard structure
function keyboard.build()
  local row = 1
  local cursorX = cfg.key_x
  local cursorY = cfg.key_y

  for i = 1, #cfg.key_map do
    if cfg.key_map[i] == nil then
      cursorX = cfg.key_x + cfg.key_size + cfg.key_gap + (cfg.key_indent * row)
      cursorY = cursorY + cfg.key_size + cfg.key_gap
      row = row + 1
    else
      structure[#structure + 1] = {
        x = cursorX,
        y = cursorY,
        w = cfg.key_size,
        h = cfg.key_size,
        key = cfg.key_map[i]
      }
      cursorX = cursorX + cfg.key_size + cfg.key_gap
    end
  end
  build_special_keys()
end

local function get_key(key)
  if key:match("^_.+") then return key end
  if not keyboard_memory.shifted then
    if keyboard_memory.capslock then
      return key:match("^(.+)/"):upper()
    end
    return key:match("^(.+)/")
  end
  return key:match("/+(.+)$")
end

local function draw_key(i)
  Drawing.setColor(util.hex(cfg.theme.main_window))
  Drawing.drawImageRect(texture, structure[i].x, structure[i].y, structure[i].w, structure[i].h)
  Drawing.reset()
end

local function draw_key_label(i)
  if structure[i].key:match("^_.+") then return end
  Drawing.setColor(util.hex(cfg.theme.title))
  Drawing.drawText(get_key(structure[i].key), structure[i].x + cfg.key_indent / 2, structure[i].y)
  Drawing.reset()
end

function keyboard.draw()
  for i = 1, #structure do
    draw_key(i)
    draw_key_label(i)
  end
end

function keyboard.input(x, y)
  for i = 1, #structure do
    if
      x >= structure[i].x and x <= structure[i].x + structure[i].w and
      y >= structure[i].y and y <= structure[i].y + structure[i].h
    then
      return get_key(structure[i].key)
    end
  end
end

return keyboard
