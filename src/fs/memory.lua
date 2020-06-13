
--- Memory of Spacebear terminal
-- Created by Olsken on 6/6/2020
-- This file needs to be initialised in the
-- main script before use.

local cfg = require("cfg")
local util = require("util")

local terminal = Util.optStorage(TheoTown.getFileStorage(), "&spb_terminal")


local function set_index(index, t_size)
  index = index or t_size
  if index <= -1 and index >= -t_size then
    index = t_size + index
  end
  return index
end

--- Functions to easily manipulate terminal line content
-- lindex = line index
local line_functions = {
  ["append"] = function(terminal, str, lindex)
    assert(type(terminal) == "table")
    assert(type(str) == "string")
    lindex = set_index(lindex, #terminal)

    terminal[lindex].content[#terminal[lindex].content] = terminal[lindex].content[#terminal[lindex].content]..str
  end,
  ["remove"] = function(terminal, meta, index, lindex)
    assert(type(terminal) == "table")
    lindex = set_index(lindex, #terminal)

    if meta then
      assert(meta == "content" or meta == "colours")
      index = set_index(index, #terminal[lindex][meta])
      table.remove(terminal[lindex][meta], index)
    else
      table.remove(terminal, lindex)
    end
  end,
  ["insert"] = function(terminal, items, meta, index, lindex)
    assert(type(terminal) == "table")
    assert(type(items) == "table")
    assert(meta == "content" or meta == "colours")
    lindex = set_index(lindex, #terminal)
    index = index and index - 1
    index = set_index(index, #terminal[lindex][meta])

    if meta == "content" then
      for i = 1, #items do
        table.insert(terminal[lindex][meta], index + i, items[i])
      end
    else
      for k, v in pairs(items) do
        terminal[lindex][meta][k] = v
      end
    end
  end,
  ["new"] = function(terminal)
    assert(type(terminal) == "table")

    terminal[#terminal + 1] = {
      content = {},
      colours = setmetatable({}, {__index = function() return cfg.theme.text end}),
    }
  end,
  ["get_element"] = function(terminal, meta, index, lindex)
    assert(type(terminal) == "table")
    assert(meta == "content" or meta == "colours")
    lindex = set_index(lindex, #terminal)

    if meta == "content" then
      index = set_index(index, #terminal[lindex][meta])
      return terminal[lindex][meta][index]
    else
      assert(type(index) == "number")
      return terminal[lindex][meta][index]
    end
  end,
  ["get_raw_data"] = function(terminal, meta, lindex)
    assert(type(terminal) == "table")
    lindex = set_index(lindex, #terminal)

    if meta then
      assert(meta == "content" or meta == "colours")
      return terminal[lindex][meta]
    end

    return terminal[lindex]
  end,
}

--- Metatable for terminal line manipulation
local line_mt = {
  __call = function(t, name, ...) return util.function_list(line_functions, name, t, ...) end
}

terminal.lines = setmetatable({}, line_mt)

--- Control view scope
terminal.start_index = nil
terminal.end_index = nil
terminal.view_scope_lock = false

--- Keyboard memory
local keyboard = Util.optStorage(TheoTown.getFileStorage(), "&spb_keyboard")

keyboard.shifted = false
keyboard.capslock = false
