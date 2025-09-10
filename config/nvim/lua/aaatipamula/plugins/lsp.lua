-- LSP plugins

return {
  'VonHeikemen/lsp-zero.nvim', branch = 'v4.x', -- Easy setup

  dependencies = {
    'neovim/nvim-lspconfig',             -- LSP standard for neovim
    'williamboman/mason.nvim',           -- Manage servers
    'williamboman/mason-lspconfig.nvim', -- Bridge mason with lspconfig
    'hrsh7th/cmp-nvim-lsp',              -- Completion for LSP
    'hrsh7th/nvim-cmp',                  -- Bridge completion with lspconfig
    'hrsh7th/cmp-buffer',                -- Suggestions from the current buffer
  },
  config = function()
    local lsp_zero = require('lsp-zero')

    -- For the buffer we are attached to if there is LSP create these binds
    local lsp_attach = function(client, bufnr)
      local opts = {buffer = bufnr}
      local builtin = require('telescope.builtin')

      function OpenDiagnostics()
        vim.b.hover_active = true
        vim.diagnostic.open_float(0, {
           scope = "cursor",
           focusable = false,
           close_events = {
             "CursorMoved",
             "CursorMovedI",
             "BufHidden",
             "InsertCharPre",
             "WinLeave",
          },
        })
      end

      -- Hover pulls up a window with the error
      vim.api.nvim_create_autocmd({'CursorHold'}, {
        group = buf_commands,
        pattern = '*',
        callback = function()
          -- Check if a hover window is active
          local active = vim.b.hover_active
          if not active then
            vim.defer_fn(function()
              OpenDiagnostics()
            end, 200) -- delay of 200ms
          end
        end
      })

      -- Reset hover if we move
      vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
        callback = function()
          vim.b.hover_active = false
        end
      })

      vim.keymap.set('n', 'K', function()
        vim.lsp.buf.hover()
        vim.b.hover_active = true
      end, opts)
      vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
      vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
      vim.keymap.set('n', 'go', builtin.lsp_type_definitions, opts)
      vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
      vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      vim.keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
      vim.keymap.set('n', 'Ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    end

    -- Load up defaults for lspconfig
    lsp_zero.extend_lspconfig({
      sign_text = true,
      lsp_attach = lsp_attach,
      capabilities = require('cmp_nvim_lsp').default_capabilities()
    })

    -- Setup handlers with borders
    lsp.setup_handlers({
      function(server)
        require("lspconfig")[server].setup({
          handlers = {
            ["textDocument/hover"] = vim.lsp.with(
              vim.lsp.handlers.hover,
              { border = "rounded" }
            ),
            ["textDocument/signatureHelp"] = vim.lsp.with(
              vim.lsp.handlers.signature_help,
              { border = "rounded" }
            ),
          }
        })
      end,
    })

    -- Set up mason for LSP servers (linters, checkers)
    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {'eslint', 'pyright', 'gopls'},
      automatic_installation = true,
      handlers = {
        function(server_name)
          local server_config = (server_name == 'clangd' and {cmd = { "clangd", '--compile-commands-dir=.' }} or {})
          require('lspconfig')[server_name].setup({server_config})
        end,
      }
    })

    -- Setup code completion
    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()
    local cmp_format = require('lsp-zero').cmp_format({details = true})

    cmp.setup({
      sources = {
        {name = 'nvim_lsp'},
        {name = 'buffer'},
      },
      formatting = cmp_format,
      snippet = {
        expand = function(args)
          -- You need Neovim v0.10 to use vim.snippet
          vim.snippet.expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
      }),
    })

    vim.diagnostic.config({
      virtual_text = false, -- Turn off inline diagnostics
      float = { border = "rounded" }, -- Global diagnostic borders
    })
  end
}

