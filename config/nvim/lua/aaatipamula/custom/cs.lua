-- local cs = "catppuccin"
local cs = "tokyonight"

-- set lualine theme
require('lualine').setup {
  options = {
    theme = cs
  }
}

-- set colorscheme
vim.cmd.colorscheme(cs)


