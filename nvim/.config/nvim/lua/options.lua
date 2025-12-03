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
