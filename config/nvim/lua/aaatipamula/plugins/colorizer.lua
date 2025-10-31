return {
  "norcalli/nvim-colorizer.lua",
  config = function ()
    require 'colorizer'.setup {
      '*'; -- Highlight all files, but customize some others.
      css = { hsl_fn = true; }; -- Enable parsing all colors functions in css.
      html = { names = false; } -- Disable parsing "names" like Blue or Gray
    }
  end
}
