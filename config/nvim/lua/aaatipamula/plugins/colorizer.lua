return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function ()
      require("colorizer").setup({
        user_default_options = {
          names = false, -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
          css = true, -- Enable all CSS *features*:
          -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
          tailwind = true, -- Enable tailwind colors
          tailwind_opts = { -- Options for highlighting tailwind names
            update_names = false, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
          },
          xterm = true, -- Enable xterm 256-color codes (#xNN, \e[38;5;NNNm)
          -- Highlighting mode.  'background'|'foreground'|'virtualtext'
          mode = "virtualtext", -- Set the display mode
          -- Virtualtext character to use
          virtualtext = "",
          -- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
          virtualtext_inline = "before",
          -- Virtualtext highlight mode: 'background'|'foreground'
          virtualtext_mode = "foreground",
        },
      })
  end
}
