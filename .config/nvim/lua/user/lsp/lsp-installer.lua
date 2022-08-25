local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end
lsp_installer.setup {}

local o = require('user.lsp.handlers').on_attach
local c = require('user.lsp.handlers').capabilities

local lspconfig = require('lspconfig')

lspconfig.sumneko_lua.setup {
  on_attach = o,
  capabilities = c
}

lspconfig.elixirls.setup {
  cmd = {'/usr/local/elixir-ls/language_server.sh'},
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
