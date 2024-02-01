local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers = {"elixirls", "pyright", "lua_ls", "marksman", "tailwindcss", "html", "tsserver"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

lspconfig["elixirls"].setup {
  cmd = { "/home/duja-pc/.local/share/nvim/mason/bin/elixir-ls" }
}

lspconfig["html"].setup {
  filetypes = {"html", "heex"}
}

lspconfig["tailwindcss"].setup {
  settings = {
    includeLanguages = {
      ["html-eex"] = "html",
      ["phoenix-heex"] = "html",
      heex = "html",
      eelixir = "html",
      elixir = "html",
    }
  },
  tailwindCSS = {
    experimental = {
      classRegex = {
        [[class= "([^"]*)]],
        [[class: "([^"]*)]],
        '~H""".*class="([^"]*)".*"""',
        '~F""".*class="([^"]*)".*"""',
      },
    },
  }
}
