-- Comment lines

return {
  'tpope/vim-commentary',

  config = function()
    -- Comment out a line in normal mode
    vim.keymap.set('n', '<leader>/', 'gcc', { remap = true })
    -- Comment out a block in visual mode
    vim.keymap.set('x', '/', 'gc', { remap = true })
  end
}

