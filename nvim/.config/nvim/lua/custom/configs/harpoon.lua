local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

-- mappings
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
-- todo: find keymaps for this. S-o is vim's insert new line above so don't use that.
-- vim.keymap.set("n", "<S-i>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<S-o>", function() harpoon:list():next() end)
