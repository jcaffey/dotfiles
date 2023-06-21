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

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})
