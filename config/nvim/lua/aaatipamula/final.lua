-- local cs = "catppuccin"
local cs = "tokyonight"

require('lualine').setup {
  options = {
    theme = cs
  }
}

vim.cmd.colorscheme(cs)

