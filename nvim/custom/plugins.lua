local plugins = {
  {
    "williamboman/mason.nvim",
     opts = {
      -- install lsp stuff 
      ensure_installed = {
        "lua-language-server",
        "pyright",
        "prettier",
        "deno",
        "typescript-language-server",
        "json-lsp",
        "bash-language-server",
      }
     }
  },

  {
    "neovim/nvim-lspconfig",
     config = function()
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
     end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults 
        "vim",
        "lua",

        -- web dev 
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        -- "vue", "svelte",

       -- low level
        "c",
      },
    },
  },
}

return plugins
