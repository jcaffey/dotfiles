-- this is a work around to get colors to work
-- correctly in lazyvim + zellij
vim.schedule(function()
  vim.cmd.colorscheme("catppuccin")
  vim.api.nvim_set_option("background", "dark")
end)
