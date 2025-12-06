return {
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
      explorer = { enabled = false },
      -- TODO:
      -- gh = {
      --   opts = {},
      --   keys = {
      --     { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
      --     { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
      --     { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
      --     { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
      --   },
      -- },
      -- gitbrowse = {
      --   opts = {},
      --   keys = {
      --     { "<leader>gB", "Snacks.gitbrowse()", desc = "View on Github" },
      --   },
      -- },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = false },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    }
  },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

-- In your plugins.lua or wherever you declare plugins
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "vim",
          "lua",
          "vimdoc",
          "html",
          "css",
          "rust",
          "elixir",
          "heex",       -- Elixir's HTML+EEX templates (very important!)
          "eex",
          "surface",    -- if you use Surface components
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false, -- recommended
        },
        -- Optional but highly recommended for Elixir
        indent = { enable = true },
        incremental_selection = { enable = true },
      })

      -- Optional: better Heex file detection
      vim.filetype.add({
        extension = {
          heex = "heex",
        },
        pattern = {
          [".*%.heex$"] = "heex",
        },
      })
    end,
  },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },

  -- oil
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require "configs.oil"
    end,
  },

  -- lazygit
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
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
      require "configs.dap"
    end,
  },

  -- harpoon man
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      require("configs.harpoon")
    end,
  },
}
