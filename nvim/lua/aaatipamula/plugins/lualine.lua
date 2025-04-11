return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
      require('lualine').setup {
        options = {
          theme = 'tokyonight',
          -- section_separators = { left = '', right = '' },
          -- component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
        },
      }
    end
}
