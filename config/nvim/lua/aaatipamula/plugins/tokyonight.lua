return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("tokyonight").setup({
      style = "night",
      transparent = true,
      lualine_bold = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      }
    })

    vim.cmd[[colorscheme tokyonight-night]]
  end,
}
