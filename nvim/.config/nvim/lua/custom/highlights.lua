-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors
-- colors are here: https://github.com/NvChad/base46/blob/v2.0/lua/base46/themes/catppuccin.lua

local M = {}

---@type Base46HLGroupsList
M.override = {
  CursorLine = {
    bg = "grey"
  },
  Comment = {
    italic = false,
    fg = "nord_blue",
  },
  Search = {
    fg = "yellow",
  },
  Visual = {
    fg = "sun",
    bg = "nord_blue",
  },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
