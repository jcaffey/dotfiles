---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["j"] = "",
    ["k"] = "",
    ["<leader>n"] = "",
  }
}

M.general = {
  n = {
    -- movement
    ["<left>"] = { "<C-w>h", "move cursor to left split" },
    ["<right>"] = { "<C-w>l", "move cursor to right split" },
    ["<up>"] = { "<C-w>k", "move cursor to upper split" },
    ["<down>"] = { "<C-w>j", "move cursor to lower split" },

    -- beginning / end of lines (i can never hit ^ first try)
    ["<C-b>"] = { "^", "beginning of line" },
    ["<C-e>"] = { "$", "end of line" },

    -- yank/paste to system register
    ["<leader>P"] = { '"*p', "Paste from * register" },
    ["<leader>Y"] = { '"*y', "Yank to * register" },

    -- splits
    ["<leader>\\"] = { ":vsplit<cr>", "vertical split" },
    ["<leader>-"] = { ":split<cr>", "horizontal split" },

    -- quickfix
    ["<leader>qf"] = { ":copen<cr>", "quick fix list" },
    ["<leader>j"] = { ":cnext<cr>", "next quick fix" },
    ["<leader>k"] = { ":cprev<cr>", "prev quick fix" },

    -- toggle trouble
    ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "toggle trouble list" },

    -- lazy git!
    ["<leader>gg"] = { "<cmd>LazyGit<cr>", "lazy git" },

    -- toggle transparency
    ["<leader>tt"] = { ':=require("base46").toggle_transparency()<cr>', "toggle transparency" },

    -- nnn picker
    ["<leader>n"] = { ':NnnPicker<cr>', "nnn picker" },
  },
  v = {
    ["<leader>P"] = { '"*p', "Paste from * register" },
    ["<leader>Y"] = { '"*y', "Yank to * register" },
    ["J"] = { ":m '>+1<cr>gv=gv", "move selected line down" },
    ["K"] = { ":m '<-2<cr>gv=gv", "move selected line up" },
    ["<leader>\\"] = { ":vsplit<cr>", "vertical split" },
    ["<leader>-"] = { ":split<cr>", "horizontal split" },
    -- nnn picker
    ["<leader>n"] = { ':NnnPicker<cr>', "nnn picker" },
  }
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<tab>"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<S-tab>"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    -- cycle through buffers
    ["b]"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["b["] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<leader>x"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },

    -- close all buffers to left
    ["<leader>bl"] = {
      function()
        require("nvchad.tabufline").closeBufs_at_direction("left")
      end,
      "Close buffers to left"
    },

    -- close all buffers to right
    ["<leader>br"] = {
      function()
        require("nvchad.tabufline").closeBufs_at_direction("right")
      end,
      "Close buffers to right"
    },

    -- new tab
    ["<leader>tn"] = {
      ":tabnew<cr>",
      "New tab",
    },

    -- close tab
    ["<leader>tx"] = {
      function()
        require('nvchad.tabufline').closeAllBufs('closeTab')
      end,
      "Close tab",
    },

    -- cycle through tabs
    ["t]"] = {
      ":tabnext<cr>",
      "Goto next tab",
    },

    ["t["] = {
      ":tabprevious<cr>",
      "Goto previous tab",
    },
  },
}

return M

