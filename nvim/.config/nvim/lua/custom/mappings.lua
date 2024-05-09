---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["j"] = "",
    ["k"] = "",
    ["<leader>n"] = "",
  }
}

M.harpoon = {
  plugin = true,
  n = {
    ["<leader>h"] = {
      function()
        _G.harpoon.ui:toggle_quick_menu(_G.harpoon:list())
      end,
      "Harpoon list"
    },
    ["<leader>ha"] = {
      function()
        _G.harpoon:list():add()
      end,
      "Harpoon add"
    },
    ["<C-h>"] = {
      function()
        _G.harpoon:list():select(1)
      end,
      "Harpoon select 1"
    },
    ["<C-j>"] = {
      function()
        _G.harpoon:list():select(2)
      end,
      "Harpoon select 2"
    },
    ["<C-k>"] = {
      function()
        _G.harpoon:list():select(3)
      end,
      "Harpoon select 3"
    },
    ["<C-l>"] = {
      function()
        _G.harpoon:list():select(4)
      end,
      "Harpoon select 4"
    },
    ["h["] = {
      function()
        _G.harpoon:list():prev()
      end,
      "Harpoon prev"
    },
    ["h]"] = {
      function()
        _G.harpoon:list():next()
      end,
      "Harpoon next"
    },
  }
}

M.general = {
  n = {
    -- harpoon2
--    ["<leader>hh"] = { function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "harpoon" },
-- vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    -- DAP debugging
    ["<leader>dk"] = { function() require('dap').continue() end, "Start / continue debugging" },
    ["<leader>dl"] = { function() require('dap').run_last() end, "Run last" },
    ["<leader>db"] = { function() require('dap').toggle_breakpoint() end, "Toggle breakpoint" },

    -- movement
    ["<left>"] = { "<C-w>h", "move cursor to left split" },
    ["<right>"] = { "<C-w>l", "move cursor to right split" },
    ["<up>"] = { "<C-w>k", "move cursor to upper split" },
    ["<down>"] = { "<C-w>j", "move cursor to lower split" },

    -- beginning / end of lines (i can never hit ^ first try)
    ["<C-b>"] = { "^", "beginning of line" },
    ["<C-e>"] = { "$", "end of line" },

    -- yank/paste to system register
    ["<leader>p"] = { '"*p', "Paste from * register" },
    ["<leader>y"] = { '"*y', "Yank to * register" },

    -- splits
    ["<leader>\\"] = { ":vsplit<cr>", "vertical split" },
    ["<leader>-"] = { ":split<cr>", "horizontal split" },

    -- quickfix
    ["<leader>qf"] = { ":copen<cr>", "quick fix list" },
    ["<leader>j"] = { ":cnext<cr>", "next quick fix" },
    ["<leader>k"] = { ":cprev<cr>", "prev quick fix" },

    -- trouble
    ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "toggle trouble list" },
    ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "toggle trouble workspace" },
    ["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "toggle trouble document" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", "toggle trouble quickfix" },
    ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", "toggle trouble loclist" },

    -- lazy git!
    ["<leader>gg"] = { "<cmd>LazyGit<cr>", "lazy git" },

    -- toggle transparency
    ["<leader>tt"] = { ':=require("base46").toggle_transparency()<cr>', "toggle transparency" },
  },
  v = {
    ["<leader>P"] = { '"*p', "Paste from * register" },
    ["<leader>Y"] = { '"*y', "Yank to * register" },
    ["J"] = { ":m '>+1<cr>gv=gv", "move selected line down" },
    ["K"] = { ":m '<-2<cr>gv=gv", "move selected line up" },
    ["<leader>\\"] = { ":vsplit<cr>", "vertical split" },
    ["<leader>-"] = { ":split<cr>", "horizontal split" },
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

