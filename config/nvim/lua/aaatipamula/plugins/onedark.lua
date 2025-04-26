return {
  'navarasu/onedark.nvim', -- OneDark Color Scheme

  config = function()
    require('onedark').setup {
      -- No italic comments
      code_style = {
        comments = 'none',
      },

      -- Theme variant config
      style = 'darker',
      toggle_style_key = '<leader>tt',
      toggle_style_list = {'darker',  'deep',  'warmer'},
    }
  end
}

