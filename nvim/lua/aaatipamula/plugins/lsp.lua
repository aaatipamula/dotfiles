-- LSP plugins

return {
  'VonHeikemen/lsp-zero.nvim', branch = 'v4.x', -- Easy setup

  dependencies = {
    'neovim/nvim-lspconfig',             -- LSP standard for neovim
    'williamboman/mason.nvim',           -- Manage servers
    'williamboman/mason-lspconfig.nvim', -- Bridge mason with lspconfig
    'hrsh7th/cmp-nvim-lsp',              -- Completion for LSP
    'hrsh7th/nvim-cmp',                  -- Bridge completion with lspconfig
  },
  config = function()
    local lsp_zero = require('lsp-zero')

    -- For the buffer we are attached to try each of these 
    local lsp_attach = function(client, bufnr)
      local opts = {buffer = bufnr}
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
      vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
      vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
      vim.keymap.set('n', 'go', builtin.lsp_type_definitions, opts)
      vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
      vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      vim.keymap.set('n', 'vrr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
      vim.keymap.set('n', 'vca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    end

    -- Load up defaults for lspconfig
    lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })

    -- Set up mason for LSP servers (linters, checkers)
    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = {'eslint', 'pyright', 'gopls'},
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })

    -- Setup code completion
    local cmp = require('cmp')
    cmp.setup({
        sources = {
          {name = 'nvim_lsp'},
        },
        snippet = {
          expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({}),
      })
  end
}

