local cs = "catppuccin"

require('lualine').setup {
  options = {
    theme = cs
  }
}

vim.cmd.colorscheme(cs)

if cs == "catppuccin" then
  -- Force clear backgrounds
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
end
