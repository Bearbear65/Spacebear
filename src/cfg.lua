
--- Config file for Spacebear
-- Created by Olsken on 6/6/2020

local cfg = {}

cfg.name = "Spacebear"
cfg.version = "0.0.1"

cfg.x = 25
cfg.y = 25
cfg.w = 200
cfg.h = 150

cfg.statusbar_height = 12

cfg.output_margin = 2
cfg.view_scope = math.floor((cfg.h - (cfg.statusbar_height + cfg.output_margin * 2)) / 10)

cfg.font = TheoTown.RESOURCES.skin.fontSmall

cfg.theme = {
  main_window = "#212022",
  statusbar = "#2F2B32",
  title = "#853BD3",
  text = "#F1F2F2",
  caret = "#504E56",
  seperator = "#50B3DD",
}

--- Keyboard config

cfg.key_x = 230
cfg.key_y = 25

cfg.key_size = 20
cfg.key_indent = math.floor(cfg.key_size / 2)
cfg.key_gap = 2

cfg.key_map = {
  "`/~", "1/!", "2/@", "3/#", "4/$", "5/%", "6/^", "7/&", "8/*", "9/(", "0/)", "-/_", "=/+", nil,
  "q/Q", "w/W", "e/E", "r/R", "t/T", "y/Y", "u/U", "i/I", "o/O", "p/P", "[/{", "]/}", "\\/|", nil,
  "a/A", "s/S", "d/D", "f/F", "g/G", "h/H", "j/J", "k/K", "l/L", ";/:", "'/\"", nil,
  "z/Z", "x/X", "c/C", "v/V", "b/B", "n/N", "m/M", ",/<", "./>", "//?", nil,
}

return cfg
