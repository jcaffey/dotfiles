local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "ruby",
    "rust",
    "swift",
    "c_sharp",
    "bash",
    "awk",
    "cpp",
    "json",
    "yaml",
    "toml",
    "dart",
    "go",
    "python",
    "terraform",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "eslint-lsp",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- mine
    "codelldb",
    "cpptools",
    "gopls",
    "pyright",
    "tailwindcss-language-server",
    "terraformls",
    "rust-analyzer",
    "markdownlint",
    "ruby_lsp",
    "rubocop",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    -- TODO: i have a sneaky suspiciion that git features are killing performance
    enable = false,
    ignore = false,
  },

  renderer = {
    root_folder_label = false,
    highlight_git = true,
    highlight_opened_files = "none",

    indent_markers = {
      enable = false,
    },

    icons = {
      show = {
        file = false,
        folder = true,
        folder_arrow = false,
        git = false,
      },
      -- glyphs = {
      --   default = "●",
      --   symlink = "",
      --   git = {
      --     unstaged = "✗",
      --     staged = "✓",
      --     unmerged = "",
      --     renamed = "➜",
      --     untracked = "★",
      --     deleted = "",
      --     ignored = "◌",
      --   },
      -- },
    },
  },
}

return M
