vim.opt.hlsearch = false  -- don't highlight
vim.opt.incsearch = true  -- incremental search

vim.opt.expandtab = true   -- converts tabs to white space
vim.opt.tabstop = 2        -- number of columns occupied by a tab
vim.opt.softtabstop = 2    -- set spaces as tabs stops so <BS> does the right thing
vim.opt.shiftwidth = 2     -- width for auto indents
vim.opt.smartindent = true -- smort hehe

vim.opt.number = true         -- add line numbers
vim.opt.relativenumber = true -- numbers relative to current line

vim.opt.swapfile = false -- no swap files
vim.opt.backup = false   -- no swap files
vim.opt.undofile = true  -- save undo history


vim.opt.linebreak = true -- wrap by word
vim.opt.ttyfast = true   -- speed up scrolling in Vim
vim.opt.mouse = 'a'      -- enable mouse click
vim.opt.termguicolors = true -- use terminal gui colors
vim.opt.splitright = true -- open splits to the right
vim.opt.splitbelow = true -- open splits below

-- no annoying sounds
vim.opt.errorbells = false
vim.opt.visualbell = true

-- Scrolling and indication
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 8

-- Faster update times
vim.opt.updatetime = 50

-- Set dracula colorscheme
-- vim.cmd[[colorscheme dracula]]
