local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
  local plugins = {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      animate = { enabled = true },
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      debug  = { enabled=true },
      ---@class snacks.dim.Config
      {
        ---@type snacks.scope.Config
        scope = {
          min_size = 5,
          max_size = 20,
          siblings = true,
        },
        -- animate scopes. Enabled by default for Neovim >= 0.10
        -- Works on older versions but has to trigger redraws during animation.
        ---@type snacks.animate.Config|{enabled?: boolean}
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          easing = "outQuad",
          duration = {
            step = 20, -- ms per step
            total = 300, -- maximum duration
          },
        },
        -- what buffers to dim
        filter = function(buf)
          return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
        end,
      },
      explorer = { enabled = true },
      -- gh = {
      --   opts = {},
      --   keys = {
      --     { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
      --     { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
      --     { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
      --     { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
      --   },
      -- },
      gitbrowse = {
        opts = {},
        keys = {
          -- keymaps are set in lua/custom/mappings.lua
          -- { "<leader>gB", "Snacks.gitbrowse()", desc = "View on Github" },
        },
      },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = false },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "nvimtools/none-ls.nvim",
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

  {
    "NvChad/ui",
    config = function()
      vim.opt.statusline=""
    end
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   init = function()
  --     -- require("core.utils").lazy_load "nvim-lspconfig"
  --   end,
  --   config = function()
  --     require "plugins.configs.lspconfig"
  --   end,
  -- },

  {
    "neovim/nvim-lspconfig",
    event = "LspAttach",  -- this is available since Neovim 0.10
    dependencies = {
      -- your other lsp-related plugins
    },
    config = function()
      require "plugins.configs.lspconfig"
    end,
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
      require("custom.configs.harpoon")
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
