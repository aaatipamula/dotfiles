vim.g.mapleader = ' '

-- Open file finder (netrw)
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Toggle spelling
vim.keymap.set('n', '<leader>ss', ':setlocal spell!<cr>')

-- Smart way to move between windows (ctrl-hjkl)
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-l>', '<C-W>l')

-- Keep cursor in middle of screen when moving pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in the middle of the screen when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- keep selection after indenting in visual (goated)
vim.keymap.set('v', 'J', ':m \'>+1<cr>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<cr>gv=gv')

-- keep selection after indenting in visual (goated)
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- greatest remap ever 
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- edit new buffer from current buffer path
vim.keymap.set('n', '<leader>e', ':e! <C-r>=expand("%:p:h")<cr>/')

-- open buffer with filename
vim.keymap.set('n', '<leader>o', ':b')

-- quit current buffer
vim.keymap.set('n', '<leader>x', ':bd<cr>')

-- open buffers 1-9
vim.keymap.set('n', '<leader>1', ':b!1<cr>')
vim.keymap.set('n', '<leader>2', ':b!2<cr>')
vim.keymap.set('n', '<leader>3', ':b!3<cr>')
vim.keymap.set('n', '<leader>4', ':b!4<cr>')
vim.keymap.set('n', '<leader>5', ':b!5<cr>')
vim.keymap.set('n', '<leader>6', ':b!6<cr>')
vim.keymap.set('n', '<leader>7', ':b!7<cr>')
vim.keymap.set('n', '<leader>8', ':b!8<cr>')
vim.keymap.set('n', '<leader>9', ':b!9<cr>')

-- next and previous buffers with
vim.keymap.set('n', '<TAB>', ':bn!<cr>')
vim.keymap.set('n', '<S-TAB>', ':bp!<cr>')


-- open horizontal terminal
vim.keymap.set('n', '<leader>h', ':sp +te term<cr>i', { silent = true })

-- open vertical terminal
vim.keymap.set('n', '<leader>v', ':vert te<cr>i', { silent = true })

-- escape insert mode in terminal Shift-ESC
vim.keymap.set('t', '<S-ESC>', '<C-\\><C-n>')

-- switch windows in terminal easier
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')

-- Setup auto commands and groups
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Create groups
local term_commands = augroup('term_commands', {})
local buf_commands = augroup('buf_commands', {})

-- Copy to system clipboad for WSL
local clip_exe = "/mnt/c/Windows/System32/clip.exe"
if vim.fn.executable(clip_exe) == 1 then
  local wsl_yank = augroup('wsl_yank', {clear = true})
  autocmd("TextYankPost", {
    group = wsl_yank,
    pattern = "*",
    callback = function()
      if vim.v.event.operator == 'y' then
        vim.fn.system(clip_exe, vim.fn.getreg('"'))
      end
    end,
  })
end

-- Turn of line numbers and relative numbers
autocmd({'TermOpen'}, {
  group = term_commands,
  pattern = '*',
  command = 'setlocal nonumber norelativenumber'
})

-- Automatically enter insert mode when we enter a terminal
autocmd({'BufEnter', 'WinEnter'}, {
  group = term_commands,
  pattern = 'term://*',
  command = 'startinsert'
})

-- Go back to the line we left off at when we reopen a file
autocmd({'BufReadPost'}, {
  group = buf_commands,
  pattern = '*',
  command = 'if line("\'\\"") > 1 && line("\'\\"") <= line("$") | exe "normal! g\'\\"" | endif'
})

