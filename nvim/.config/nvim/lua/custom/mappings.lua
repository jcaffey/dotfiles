---@type MappingsTable
local M = {}

-- TODO: these are copied from nvchad's default mappings - i don't know why they
-- arent working without being delcared here.
M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" }})
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next({ float = { border = "rounded" }})
      end,
      "Goto next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },
}

M.disabled = {
  n = {
    ["j"] = "",
    ["k"] = "",
    ["<leader>n"] = "",
  }
}

M.general = {
  n = {
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

