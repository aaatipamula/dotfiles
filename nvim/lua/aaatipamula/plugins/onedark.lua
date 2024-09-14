return {
  'navarasu/onedark.nvim', -- OneDark Color Scheme

  config = function()
    require('onedark').setup {
      -- No italic comments
      code_style = {
        comments = 'none',
      },

      -- Theme variant
      style = 'darker',
    }

    require('onedark').load()
  end
}

