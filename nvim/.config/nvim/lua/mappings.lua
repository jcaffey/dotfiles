require "nvchad.mappings"

local map = vim.keymap.set

-- this is a good idea, except ; repeats last movement which is useful
-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

--
-- splits
map("n", "<leader>\\", ":vsplit<cr>", { desc = "vertical split" })
map("n", "<leader>-", ":split<cr>", { desc = "horizontal split" })
map("v", "<leader>\\", ":vsplit<cr>", { desc = "vertical split" })
map("v", "<leader>-", ":split<cr>", { desc = "horizontal split" })

-- oil
map("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
map("n", "<leader>e", function() require('oil').open_float('.') end, { desc = "Open oil in floating window at root" })

-- spectre
map("n", "<leader>S", function() require("spectre").toggle() end, { desc = "Spectre" })

-- DAP debugging
map("n", "<leader>dk", function() require('dap').continue() end, { desc = "Start / continue debugging" })
map("n", "<leader>dl", function() require('dap').run_last() end, { desc = "Run last" })
map("n", "<leader>db", function() require('dap').toggle_breakpoint() end, { desc = "Toggle breakpoint" })

-- arrow movement
map("n", "<left>", "<C-w>h", { desc = "move cursor to left split" })
map("n", "<right>", "<C-w>l", { desc = "move cursor to left split" })
map("n", "<up>", "<C-w>k", { desc = "move cursor to left split" })
map("n", "<down>", "<C-w>j", { desc = "move cursor to left split" })

-- lazy git!
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "lazy git" })

-- beginning / end of lines (i can never hit ^ first try)
map("n", "<C-b>", "^", { desc = "beginning of line" })
map("n", "<C-e>", "$", { desc = "end of line" })

-- quickfix
map("n", "<leader>qf", ":copen<cr>", { desc = "quick fix list" })
map("n", "<leader>j", ":cnext<cr>", { desc = "next quick fix" })
map("n", "<leader>k", ":cprev<cr>", { desc = "previous quick fix" })

-- trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble Diagnostics" })
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Trouble Workspace Diagnostics" })
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Trouble Document Diagnostics" })
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Trouble Quickfix" })
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Trouble Loclist" })

-- visual mode
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "move selected line down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "move selected line up" })
