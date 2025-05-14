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

-- Keep selection after moving in visual (goated)
vim.keymap.set('v', '<C-j>', 'J', { noremap = true })
vim.keymap.set('v', 'J', ':m \'>+1<cr>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<cr>gv=gv')

-- Keep selection after indenting in visual (goated)
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Greatest remap ever 
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Edit new buffer from current buffer path
vim.keymap.set('n', '<leader>e', ':e! <C-r>=expand("%:p:h")<cr>/')

-- Open buffer with filename
vim.keymap.set('n', '<leader>o', ':b')

-- Quit current buffer
vim.keymap.set('n', '<leader>x', ':bd<cr>')


-- Next and previous buffers with
vim.keymap.set('n', '<TAB>', ':bn!<cr>', { silent = true })
vim.keymap.set('n', '<S-TAB>', ':bp!<cr>', { silent = true })


-- Open horizontal terminal
vim.keymap.set('n', '<leader>h', ':sp +te term<cr>i', { silent = true })

-- Open vertical terminal
vim.keymap.set('n', '<leader>v', ':vert te<cr>i', { silent = true })

-- Escape insert mode in terminal Shift-ESC
vim.keymap.set('t', '<S-ESC>', '<C-\\><C-n>')

-- Switch windows in terminal easier
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')

-- Go to a buffer by index
function BufferGoto(index)
  local buffers = vim.fn.getbufinfo({buflisted = 1})
  if buffers[index] then
    vim.api.nvim_set_current_buf(buffers[index].bufnr)
  else
    print("No buffer at index " .. index)
  end
end

-- Create keymaps for buffer indexes 1-9
for i = 1, 9 do
  vim.keymap.set('n', '<leader>'..i, function()
    BufferGoto(i)
  end, { noremap = true, silent = true })
end

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

-- Fix Tmux navigator not working when native nvim terminal is opened
autocmd('TermEnter', {
  group = term_commands,
  pattern = '*',
  callback = function()
    vim.keymap.set('t', '<C-h>', '<Cmd>TmuxNavigateLeft<CR>', { buffer = 0 })
    vim.keymap.set('t', '<C-j>', '<Cmd>TmuxNavigateDown<CR>', { buffer = 0 })
    vim.keymap.set('t', '<C-k>', '<Cmd>TmuxNavigateUp<CR>', { buffer = 0 })
    vim.keymap.set('t', '<C-l>', '<Cmd>TmuxNavigateRight<CR>', { buffer = 0 })
  end
})

-- Go back to the line we left off at when we reopen a file
autocmd({'BufReadPost'}, {
  group = buf_commands,
  pattern = '*',
  command = 'if line("\'\\"") > 1 && line("\'\\"") <= line("$") | exe "normal! g\'\\"" | endif'
})

