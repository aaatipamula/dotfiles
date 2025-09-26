local cs = "catppuccin"

require('lualine').setup {
  options = {
    theme = cs
  }
}

vim.cmd.colorscheme(cs)
