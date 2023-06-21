---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["j"] = "",
    ["k"] = "",
    ["<leader>x"] = "",
  }
}

M.general = {
  n = {
    ["<left>"] = { "<C-w>h", "move cursor to left split" },
    ["<right>"] = { "<C-w>l", "move cursor to right split" },
    ["<up>"] = { "<C-w>k", "move cursor to upper split" },
    ["<down>"] = { "<C-w>j", "move cursor to lower split" },
    ["<leader>P"] = { '"*p', "Paste from * register" },
    ["<leader>Y"] = { '"*y', "Yank to * register" },
    ["<leader>\\"] = { ":vsplit<cr>", "vertical split" },
    ["<leader>-"] = { ":hsplit<cr>", "horizontal split" },
    ["<leader>qf"] = { ":copen<cr>", "quick fix list" },
    ["<leader>j"] = { ":cnext<cr>", "next quick fix" },
    ["<leader>k"] = { ":cprev<cr>", "prev quick fix" },
    ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "toggle trouble list" },
    ["<leader>gg"] = { "<cmd>LazyGit<cr>", "lazy git" },

    -- close all tabs
    ["<leader>tx"] = { ':=require("nvchad_ui.tabufline").closeAllBufs()<cr>', "close all tabs" },

    -- close all tabs to left
    ["<leader>tl"] = { ':=require("nvchad_ui.tabufline").closeBufs_at_direction("left")<cr>', "close tabs to left" },

    -- close all tabs to right
    ["<leader>tr"] = { ':=require("nvchad_ui.tabufline").closeBufs_at_direction("right")<cr>', "close tabs to right" },
  },
  v = {
    ["<leader>P"] = { '"*p', "Paste from * register" },
    ["<leader>Y"] = { '"*y', "Yank to * register" },
    ["J"] = { ":m '>+1<cr>gv=gv", "move selected line down" },
    ["K"] = { ":m '<-2<cr>gv=gv", "move selected line up" },
    ["<leader>\\"] = { ":vsplit<cr>", "vertical split" },
    ["<leader>-"] = { ":hsplit<cr>", "horizontal split" },
  }
}


-- more keybinds!

return M

