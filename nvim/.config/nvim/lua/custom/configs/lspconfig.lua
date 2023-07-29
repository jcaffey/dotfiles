local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local util = require("lspconfig.util")
local lspconfig = require("lspconfig")


-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "tsserver",
  "clangd",
 -- "ruby_ls", - use custom config below... this one is broken
  "tailwindcss",
  "csharp_ls",
  "sourcekit",
  "rust_analyzer",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- manually setup
-- dart
lspconfig.dartls.setup(
{
  default_config = {
    cmd = { 'dart', 'language-server', '--protocol=lsp' },
    filetypes = { 'dart' },
    root_dir = util.root_pattern 'pubspec.yaml',
    init_options = {
      onlyAnalyzeProjectsWithOpenFiles = true,
      suggestFromUnimportedLibraries = true,
      closingLabels = true,
      outline = true,
      flutterOutline = true,
    },
    settings = {
      dart = {
        completeFunctionCalls = true,
        showTodos = true,
      },
    },
  },
  docs = {
    description = [[
https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server/tool/lsp_spec

Language server for dart.
]],
    default_config = {
      root_dir = [[root_pattern("pubspec.yaml")]],
    },
  },
})
--
-- lspconfig.pyright.setup { blabla}
--
-- Without the loop, you would have to manually set up each LSP 
-- 
-- lspconfig.html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- lspconfig.cssls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--

local configs = require("lspconfig.configs")

if not configs.ruby_lsp then
	local enabled_features = {
		"documentHighlights",
		"documentSymbols",
		"foldingRanges",
		"selectionRanges",
		-- "semanticHighlighting",
		"formatting",
		"codeActions",
	}

	configs.ruby_lsp = {
		default_config = {
			cmd = { "bundle", "exec", "ruby-lsp" },
			filetypes = { "ruby" },
			root_dir = util.root_pattern("Gemfile", ".git"),
			init_options = {
				enabledFeatures = enabled_features,
			},
			settings = {},
		},
		commands = {
			FormatRuby = {
				function()
					vim.lsp.buf.format({
						name = "ruby_lsp",
						async = true,
					})
				end,
				description = "Format using ruby-lsp",
			},
		},
	}
end

lspconfig.ruby_ls.setup {
  on_attach = function(client, buffer)
    local callback = function()
    local params = vim.lsp.util.make_text_document_params(buffer)

    client.request(
      'textDocument/diagnostic',
      { textDocument = params },
      function(err, result)
        if err then return end

        vim.lsp.diagnostic.on_publish_diagnostics(
          nil,
          vim.tbl_extend('keep', params, { diagnostics = result.items }),
          { client_id = client.id }
        )
      end
    )
  end

  callback() -- call on attach

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePre', 'BufReadPost', 'InsertLeave', 'TextChanged' }, {
    buffer = buffer,
    callback = callback,
  })
end,
  capabilities = capabilities,
}
