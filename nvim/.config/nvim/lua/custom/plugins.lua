local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
    enabled = false, -- disabled for oil
  },

  -- Custom plugins to install start here. Always try to lazy load them for performance reasons.


  {
    'stevearc/oil.nvim',
    opts = {},
    lazy = false,
    -- Optional dependencies
    -- dependencies = { "echasnovski/mini.icons" },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function()
      require "custom.configs.oil"
    end
  },

  -- better escape
  -- {
  --   "max397574/better-escape.nvim",
  --   event = "InsertEnter",
  --   config = function()
  --     require("better_escape").setup()
  --   end,
  -- },

  -- lazygit
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
  },

  -- yazi
  {
    "DreamMaoMao/yazi.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },

    keys = {
      { "<leader>n", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
    },
  },

  -- ripgrep
  {
    "jremmen/vim-ripgrep",
    lazy = false,
  },

  -- undotree
  {
    "mbbill/undotree",
    lazy = false,
  },

  -- surround
  {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  },

  -- trouble
  {
   "folke/trouble.nvim",
   -- dependencies = { "nvim-tree/nvim-web-devicons" },
   lazy = false,
   opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
   },
  },

  -- rubocop
  {
   "ngmy/vim-rubocop",
   lazy = false,
   config = function()
   end
  },

  -- spectre
  {
   "nvim-pack/nvim-spectre",
   lazy = false,
  },

  -- DAP
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    config = function()
      require "custom.configs.dap"
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      -- todo: how should the mapps get access to harpoon?
      -- previously i was setting a global variable. but i'd rather
      -- it be local and just define the mappings here... though,
      -- it wont show up in whichkey
      -- require("core.utils").load_mappings("harpoon")

      -- mappings
      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<S-j>", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<S-k>", function() harpoon:list():next() end)
    end,
  },
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
