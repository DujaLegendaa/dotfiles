local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end
lsp_installer.setup {}

local o = require('user.lsp.handlers').on_attach
local c = require('user.lsp.handlers').capabilities

local lspconfig = require('lspconfig')

lspconfig.arduino_language_server.setup {
  cmd = {
    "arduino-language-server",
    "-clangd", "/usr/bin/clangd",
    "-cli", "/usr/bin/arduino-cli",
    "-cli-config", "~/.arduino15/arduino-cli.yaml",
    "-fqbn", "esp8266:esp8266:nodemcuv2"
  }
}


lspconfig.elixirls.setup {
  cmd = {'/usr/local/elixir-ls/language_server.sh'},
  on_attach = o,
  capabilities = c
}

lspconfig.rust_analyzer.setup {
  on_attach = o,
  capabilities = c
}

lspconfig.tsserver.setup {
  on_attach = o,
  capabilities = c,
  root_dir = function() return vim.loop.cwd() end
}

lspconfig.hls.setup {
  on_attach = o,
  capabilities = c
}

lspconfig.pyright.setup {
  on_attach = o,
  capabilities = c
}

lspconfig.dockerls.setup {
  on_attach = o,
  capabilities = c
}

lspconfig.clojure_lsp.setup {
  on_attach = o,
  capabilities = c
}

lspconfig.sqlls.setup {
  on_attach = o,
  capabilities = c
}

lspconfig.marksman.setup {
  on_attach = o,
  capabilities = c
}

lspconfig.tailwindcss.setup {
  init_options = {
		userLanguages = {
			elixir = "phoenix-heex",
			heex = "phoenix-heex",
		},
	},
	handlers = {
		["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
			vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
		end,
	},
	settings = {
		includeLanguages = {
			typescript = "javascript",
			typescriptreact = "javascript",
			["html-eex"] = "html",
			["phoenix-heex"] = "html",
			heex = "html",
			eelixir = "html",
		},
		tailwindCSS = {
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning",
			},
			validate = true,
		},
	},
	filetypes = {
		"css",
		"scss",
		"sass",
		"html",
		"heex",
		"elixir",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
  on_attach = o,
  capabilities = c
}
