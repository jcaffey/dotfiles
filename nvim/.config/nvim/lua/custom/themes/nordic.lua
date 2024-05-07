-- credits to original theme https://rosepinetheme.com/
-- this is a modified version of it

local M = {}


M.base_30 = {
  black = "#191D24", --  nvim bg
  darker_black = "#1E222A",
  white = "#BBC3D4",
  black2 = "#222630",
  one_bg = "#262431", -- real bg of onedark
  one_bg2 = "#2d2b38",
  one_bg3 = "#353340",
  grey = "#242933",
  grey_fg = "#2E3440",
  grey_fg2 = "#3B4252",
  light_grey = "#60728A",
  red = "#BF616A",
  baby_pink = "#C5727A",
  pink = "#ff83a6",
  line = "#2e2c39", -- for lines like vertsplit
  green = "#ABE9B3",
  vibrant_green = "#b5f3bd",
  nord_blue = "#5E81AC",
  blue = "#81A1C1",
  yellow = "#EFD49F",
  sun = "#EBCB8B",
  purple = "#c4a7e7",
  dark_purple = "#bb9ede",
  teal = "#6aadc8",
  orange = "#f6c177",
  cyan = "#a3d6df",
  statusline_bg = "#201e2b",
  lightbg = "#2d2b38",
  pmenu_bg = "#c4a7e7",
  folder_bg = "#6aadc8",
}

M.base_16 = {
  base00 = "#191724",
  base01 = "#1f1d2e",
  base02 = "#26233a",
  base03 = "#6e6a86",
  base04 = "#908caa",
  base05 = "#e0def4",
  base06 = "#e0def4",
  base07 = "#524f67",
  base08 = "#eb6f92",
  base09 = "#f6c177",
  base0A = "#ebbcba",
  base0B = "#31748f",
  base0C = "#9ccfd8",
  base0D = "#c4a7e7",
  base0E = "#f6c177",
  base0F = "#524f67",
}

M = require("base46").override_theme(M, "nordic")

M.type = "light"

return M
