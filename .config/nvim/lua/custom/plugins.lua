local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "python",

        "elixir",
        "eex",
        "heex",

        "fish",
        "html"
      }
    }
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "elixir-ls",
        "pyright",
        "lua-language-server"
      }
    }
  }
}

return plugins
