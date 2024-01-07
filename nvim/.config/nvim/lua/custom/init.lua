-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- aliases for my bad typing habits
vim.cmd("ca Wq wq")
vim.cmd("ca W w")
vim.cmd("ca Q q")
vim.cmd("ca Qa qa")

-- do not share clipboard with system
vim.o.clipboard = ""

-- default to relative line numbers
vim.wo.relativenumber = true

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- neovide settings
if vim.g.neovide then
  vim.g.neovide_transparency = 0.1
  vim.g.neovide_fullscreen = false -- no transparency on macosx when fullscreen mode
  vim.g.neovide_floating_blur_amount_x = 5.0
  vim.g.neovide_floating_blur_amount_y = 5.0
  -- vim.g.neovide_background_color = "#333"
end
