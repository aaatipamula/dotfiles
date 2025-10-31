-- Better Syntax Highlighting

return {
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      run = ':TSUpdate',
      config = function()

        -- require("nvim-treesitter.parsers").get_parser_configs().clam = {
        --   install_info = {
        --     url = "~/projects/tree-sitter-clam", -- local path or git repo
        --     files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
        --   },
        --   filetype = "lam", -- if filetype does not match the parser name
        -- }

        -- vim.filetype.add({
        --   extension = {
        --     lam = "clam",
        --   },
        -- })

        -- vim.treesitter.language.register('clam', { 'lam' })

        require('nvim-treesitter.configs').setup {
          -- A list of parser names, or "all" (the listed parsers MUST always be installed)
          ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "markdown",
            "markdown_inline",
            "javascript",
            "typescript",
            "python",
            "go",
          },
          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = false,

          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = true,

          -- Indent my files
          indent = {
            enable = true,
          },

          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "<A-space>",
              node_incremental = "<A-space>",
              scope_incremental = false,
              node_decremental = "<bs>",
            },
          },

          highlight = {
            enable = true,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
          },
        }
      end
}
