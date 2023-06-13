-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("update_colors")

require("lspconfig").sourcekit.setup({})
