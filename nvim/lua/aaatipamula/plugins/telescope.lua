-- Fuzzy finding, assorted pickers

return {
    'nvim-telescope/telescope.nvim',

    lazy = false,
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({})

      local builtin = require('telescope.builtin')

      -- Finding files
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) 
      vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
      vim.keymap.set('n', '<leader>rg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>gs', builtin.git_status, {})

      -- Spell Suggest
      vim.keymap.set('n', '<leader>z', builtin.spell_suggest, {})
    end
}

