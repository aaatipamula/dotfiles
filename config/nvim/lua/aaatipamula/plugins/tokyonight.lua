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
      on_highlights = function(hl, c)
        hl.SpellBad = {
          fg = c.red,       -- use Tokyonight's built-in red
          sp = c.red,       -- use Tokyonight's built-in red
          underline = true, -- keep the style
        }
      end,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      }
    })

    vim.cmd[[colorscheme tokyonight-night]]
  end,
}
