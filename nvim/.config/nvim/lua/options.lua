require "nvchad.options"

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- aliases for my bad typing habits
vim.cmd("ca Wq wq")
vim.cmd("ca W w")
vim.cmd("ca Q q")
vim.cmd("ca Qa qa")

-- Highlight on yank
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- search colors
--
-- Gruvbox-style
-- vim.api.nvim_set_hl(0, "Search",    { bg = "#fe8019", fg = "#282828", bold = true })
-- vim.api.nvim_set_hl(0, "IncSearch",    { bg = "#b16286", fg = "#ebdbb2" })       -- purple
--
-- -- Everforest / nightfox style
vim.api.nvim_set_hl(0, "Search",    { bg = "#a7c080", fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#e67e80", fg = "#000000", bold = true })

-- Pure underline instead of background (very clean)
-- vim.api.nvim_set_hl(0, "Search",    { underline = true, sp = "#ff9900" })
-- vim.api.nvim_set_hl(0, "IncSearch", { underline = true, sp = "#ff5555", bold = true })
