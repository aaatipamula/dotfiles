return {
  "lewis6991/gitsigns.nvim",
  config = function ()
    require('gitsigns').setup({})

    -- Text object for git hunks
    vim.keymap.set({'o', 'x'}, 'ih', '<Cmd>Gitsigns select_hunk<CR>')

    -- Keybinds for managing hunks
    vim.keymap.set('n', '<leader>ghr', '<Cmd>Gitsigns reset_hunk<CR>')
    vim.keymap.set('n', '<leader>ghs', '<Cmd>Gitsigns reset_hunk<CR>')
    vim.keymap.set('n', '<leader>ghd', '<Cmd>Gitsigns preview_hunk_inline<CR>')
  end
}
