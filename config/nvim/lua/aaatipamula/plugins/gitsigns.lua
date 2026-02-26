return {
  "lewis6991/gitsigns.nvim",
  config = function ()
    require('gitsigns').setup({})

    -- Text object for git hunks
    vim.keymap.set({'o', 'x'}, 'ih', '<Cmd>Gitsigns select_hunk<CR>')
  end
}
